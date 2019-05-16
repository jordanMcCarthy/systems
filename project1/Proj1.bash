#!/bin/bash

go=0;

while [ $go ]; do
    
    echo "Enter of the of the following actions or press CTRL-D to exit"
    echo "C - create a customer file"
    echo "P - accept a customer payment"
    echo "F - find customer by apartment number" 

    if ! read ans; then
        break
    fi

    case "$ans" in
        [Cc]) ./create.bash
            break
            ;;
        [Pp]) ./payment.bash
            break
            ;;
        [Ff]) ./find.bash
            break
            ;;
        *) echo "Error: invalid action value"
    esac
    done
