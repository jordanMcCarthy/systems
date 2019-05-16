#!/bin/bash

read -p "Enter customer email: " paymentEmail
read -p "Enter payment amount: " paymentAmount

if [ ! -r ./Data/$paymentEmail ];then
    echo "Error: customer not found"
    ./Proj1.bash
else

export paymentAmount
bash payment2.bash < ./Data/$paymentEmail
 
./Proj1.bash
fi
