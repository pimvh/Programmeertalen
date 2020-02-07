#!/bin/bash

#create directory
if [ ! -e "$DIR_NAME" ]       # Check if dir exists.
then
    echo "creating $DIR_NAME..."
    exit 1
fi
