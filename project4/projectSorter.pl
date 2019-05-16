#!/usr/bin/perl -w 
use strict;

# initalizes variables
my @files = glob("$ARGV[0]/*");
my $path;
my $dirName;
my $miscDir = "./$ARGV[0]/misc";

# input validation
if ($#ARGV != 0){
    print "Usage: projectSorter.pl [directory]\n";
    die "please use only one directory";
}

# loops through files in file array
# and checks to see if file name matches
# project regex and if not makes misc directory
foreach my $file (@files) {
    
    if($file =~ /proj(.*)\..*/){
        $path = $1;                              # grabs project name
        $dirName = "./$ARGV[0]/assignment$path";    # variable for path name
        
        # checks to see if directory exists
        # if it does the file is added to directory
        # otherwise the directory is made and the file
        # is moved to said directory
        if ( -d $dirName){                          
            `mv $file $dirName`;
        }else{
            `mkdir $dirName && mv $file $dirName`;
    }
    }
    if($file !~ /proj(.*)\..*/){                # misc directory
        
        # checks to see if misc directory exists
        # if it does the file is added to directory
        # otherwise the misc directory is made and the
        # file is moved to said directory
        if ( -d $miscDir){
            ` mv $file $miscDir`;
        }else{
            `mkdir $miscDir && mv $file $miscDir`;
        }
   
    

}
    
}
