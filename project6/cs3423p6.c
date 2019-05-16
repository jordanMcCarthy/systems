#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include "cs3423p6.h"


int concCmd(Cmd cmdM[], int iCmdCnt, Token tokenM[], int iTokenCnt){
    long lForkPid;
    int inputFD, outputFD;
    int i, status, j, insides;
    pid_t cpid, mypid;
    for(i=0;i<iCmdCnt;i++)
    {
        lForkPid = fork();
        insides = 1;
        
    switch(lForkPid)
    {
        case -1:
            errExit("fork failed: %s", strerror(errno));
            break;
        case 0:
            if (cmdM[i].iStdinRedirectIdx != 0){
                inputFD = open(tokenM[cmdM[i].iStdinRedirectIdx], O_RDONLY);
                if (inputFD == -1)
                    errExit("could not open file: %s", strerror(errno));
                if (dup2(inputFD, STDIN_FILENO) == -1)
                    errExit("Error: %s", strerror(errno));
                if (inputFD != STDIN_FILENO)
                    close(inputFD);
                    }
            if (cmdM[i].iStdoutRedirectIdx != 0){
                outputFD = open(tokenM[cmdM[i].iStdoutRedirectIdx], O_WRONLY|O_CREAT|O_EXCL);
                if (outputFD == -1)
                    errExit("Error: %s", strerror(errno));
                if (dup2(outputFD, STDOUT_FILENO) == -1)
                    errExit("Error: %s", strerror(errno));
                if (outputFD != STDOUT_FILENO)
                    close(outputFD);
            }
            
        char **execArgv = malloc(sizeof(char *) * MAX_ARGS + 1);
        execArgv[0] = cmdM[i].szCmdNm;
        for(j = cmdM[i].iBeginIdx; j <= cmdM[i].iEndIdx; j++){
            execArgv[insides] = tokenM[j];
            insides++;
            }   
            fprintf(stderr, "%ld  %ld: %s\n", (long) getppid(), (long) getpid(), cmdM[i].szCmdNm);
            execvp(cmdM[i].szCmdNm, execArgv);
           
        }  
    }
            for(i=0;i<iCmdCnt;i++){
                wait(&status);
                    if(status != 0);
                    return status;
                }
    return 0;
}
    

int pipeCmd(Cmd cmdM[], int iCmdCnt, Token tokenM[], int iTokenCnt){

    long lForkPid, lForkPidTwo;
    int fdM[2];
    int inputFD, outputFD, dupStat;
    int status;
    int j;
    int insidesOne = 1;
    int insidesTwo = 1;
    
    if (pipe(fdM) == -1)
        errExit("Pipe failed: %s", strerror(errno));

    lForkPid = fork();

    switch(lForkPid)
    {
        case -1:
            errExit("Error: %s", strerror(errno));
        case 0:
            if (cmdM[0].iStdinRedirectIdx != 0){
                inputFD = open(tokenM[cmdM[0].iStdinRedirectIdx], O_RDONLY);
                if (inputFD == -1)
                    errExit("Error: %s", strerror(errno));
                dupStat = dup2(inputFD, STDIN_FILENO);
                if (inputFD != STDIN_FILENO)
                    close(inputFD);   
                if (dupStat == -1)
                    errExit("Error: %s", strerror(errno));
        }

        dupStat = dup2(fdM[1], STDOUT_FILENO);
        if (dupStat == -1)
            errExit("Error: %s", strerror(errno));
        close(fdM[1]);
        char **execArgv = malloc(sizeof(char *) * MAX_ARGS + 1);
        execArgv[0] = cmdM[0].szCmdNm;
        for(j = cmdM[0].iBeginIdx; j <= cmdM[0].iEndIdx; j++){
                execArgv[insidesOne] = tokenM[j];
                insidesOne++;
        }

         execvp(cmdM[0].szCmdNm, execArgv);
         
    
    

        default:
            wait(&status); 
            close(fdM[1]);
            lForkPidTwo = fork();
            switch(lForkPidTwo) 
            {
                case -1: 
                    errExit("Error: %s", strerror(errno));
                case 0: 
                    if (cmdM[1].iStdoutRedirectIdx != 0){
                        outputFD = open(tokenM[cmdM[1].iStdoutRedirectIdx], O_WRONLY|O_CREAT|O_EXCL); 
                        if (outputFD == -1)
                            errExit("Error: %s", strerror(errno));
                        dupStat = dup2(outputFD, STDOUT_FILENO);
                        if (dupStat == -1)
                            errExit("Error: %s", strerror(errno));
                    }
                    dupStat = dup2(fdM[0], STDIN_FILENO);
                    if (dupStat == -1)
                        errExit("Error: %s", strerror(errno));
                    close(fdM[0]);
                    char **execArgvTwo = malloc(sizeof(char *) * MAX_ARGS + 1);
                    execArgvTwo[0] = cmdM[1].szCmdNm;
                    for(j = cmdM[1].iBeginIdx; j <= cmdM[1].iEndIdx; j++){
                            execArgv[insidesTwo] = tokenM[j];
                            insidesTwo++;
                            }
                    execvp(cmdM[1].szCmdNm, execArgvTwo);
             
                default:
                    wait(&status);  
                    close(fdM[0]);
                    fprintf(stderr, "1 %ld  %ld: %s\n", (long) getpid(), lForkPid, cmdM[0].szCmdNm);
                    fprintf(stderr, "1 %ld  %ld: %s\n", (long) getpid(), lForkPidTwo, cmdM[1].szCmdNm);
                    fflush(stderr);
                    return 0;
            }
    }
}
    




 
