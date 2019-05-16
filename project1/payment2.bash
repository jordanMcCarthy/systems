#!/bin/bash

read email first last
read apt rent balance dueDate

balance=$(($balance - $paymentAmount))

echo $email $first $last > ./Data/$email
echo $apt $rent $balance $dueDate >> ./Data/$email


