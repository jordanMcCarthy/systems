#!/usr/bin/perl -w
use strict;

# initalize regex variable
my $regex;

# input validation
if($#ARGV < 1){
    print "Usage: find.pl [options] [perlRegexPattern] [listOfFiles]\n";
    die "Please supply correct number of arguments";
}

# find.pl without options
if($ARGV[0] ne "-i"){

    # regex variable given first argument
    # and files of directory are added to
    # an array
    my $regex = shift;
    my @files = grep(-f, @ARGV);

    # loop which finds files based on regex match
    # on file name/file contents
    foreach my $file(@files){
        my $formatted = (split /\//, $file)[1]; #displays file name withouth path

        if ($file =~ /$regex/)  #checks filename against regex
        {
            print "$formatted\n";
        }else{                  #checks for regex match on contents
            open(INFILE, "<", "$file");
            while(my $line = <INFILE>){
                if ($line =~ /$regex/){
                    print "$formatted: $line";
                }
            
                }
            close(INFILE);
        }
    }
}

# find.pl with option -i
# this option inverses find.pl
if($ARGV[0] eq "-i"){

    # regex variable given regex
    # and files of directory are 
    # added to an array
    $regex = $ARGV[1];
    my @files = grep(-f, @ARGV);

    # loop which finds files that do not match
    # the given regex in either the filename or contents
    foreach my $file(@files){
      my $match = 0; #flag for matches
      my $formatted = (split /\//, $file)[1]; #displays file name without path
      if ($file =~ /$regex/) #checks filename against regex and if matched changes match flag to 1
      {
           $match=1;
     }else{
         open(INFILE, "<", "$file"); #checks for regex match on contents
         while(my $line = <INFILE>){
             if ($line =~ /$regex/){
                 $match=1;
                 }
            }
         if ($match == 0){          #prints all files that do not match regex on filename or contents
             print "$formatted\n";
         }
}
        close(INFILE);
}
    }

