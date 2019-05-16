#!/bin/bash

# runs sed files on each log and appends
# lastlog2.out to the end of lastlog1.out
sed -f p2a.sed lastlog1.out > logB.txt
sed -f p2a.sed lastlog2.out >> logB.txt

# sorts combined logs in preparation for
# uniq -c which puts a count on each 
# user ID found
sort logB.txt > logBSorted.txt
uniq -c logBSorted.txt > uniqueB.txt

# sed file to delete all User IDs that
# only appear once which gives end result
sed -f p2b.sed uniqueB.txt > p2bOut.txt

# remove intermediate files
rm logB.txt
rm logBSorted.txt
rm uniqueB.txt
