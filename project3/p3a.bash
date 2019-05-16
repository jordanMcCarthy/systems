#!/bin/bash

# pipes p3a1.awk through sort into p3a2.awk to alphabetically sort by last 
# name and preserve the original format of names
awk -f p3a1.awk unsortedNames.txt | sort | awk -f p3a2.awk > sortedNames.txt 
