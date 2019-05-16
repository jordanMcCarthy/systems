#!/bin/bash


# run sed scripts to get users who haven't logged
# into fox01 or fox02 servers in 2017
sed -f p2a.sed lastlog1.out > log.txt
sed -f p2aDollar.sed lastlog2.out > log2.txt

echo "sed complete"
echo "grep intializing..."

# uses log2.txt as pattern match to get the 
# intersection of users in both log#.txt files
grep -f log2.txt log.txt > p2aOut.txt

# removes intermediate files
rm log.txt 
rm log2.txt
