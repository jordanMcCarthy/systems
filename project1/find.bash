#!/bin/bash

read -p "Please enter apartment number: " aptNum

for file in $(grep -F -w -d skip -l  "$aptNum" ./Data/*);do
    
    bash find2.bash < $file

done

if [ -z "$file" ]; then
    echo "Error: apartment number not found"
fi

./Proj1.bash
