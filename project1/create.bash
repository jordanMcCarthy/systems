#!/bin/bash

read -p "Enter customer email: " customerEmail
read -p "Enter customer full name: " customerFirst customerLast
read -p "Enter apartment number: " apartmentNumber
read -p "Monthly rent amt: " monthlyRent
read -p "Next due date: " dueDate

accountBalance=0

if [ -e ./Data/$customerEmail ]; then
    echo "Error: customer already exists"
    ./Proj1.bash;
else

echo $customerEmail $customerFirst $customerLast > ./Data/$customerEmail
echo $apartmentNumber $monthlyRent $accountBalance $dueDate >> ./Data/$customerEmail



./Proj1.bash
fi
