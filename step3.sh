#!/bin/bash

if grep -q "84" $1;
    then echo "Wrong File"
elif grep -q "42" $1
    then echo "Good File"
else
    :
fi
