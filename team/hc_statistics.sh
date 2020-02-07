#!/bin/bash

DIR_NAME="hc-logs"
FILE_PREFIX="param"
FILE_EXTENSION='*.dat'

HEADER_END_STRING='Knapsack'
GREP_OPTS="-hon -m 1"

if [ $# -ne 0 ]
then
  echo "Usage: `basename $0`"
  exit $E_BADARGS
fi

# AWK_ARG="-verbose $VERBOSE -nr_items $NR_ITEM -dimensions $DIMENSIONS -solver $SOLVER -nr_iterations $NR_ITERATIONS"

cd ..

#create directory
if [ ! -e "$DIR_NAME" ]       # Check if dir exists.
then
    echo "$DIR_NAME does not exit, please run ./hc_experiments.sh first."
    exit 1
fi

FILES=$(find -name "$FILE_EXTENSION")

for file in $FILES
do
    echo $file
    # find 'Knapsack' in file, and start reading from the line below it.
    HEADER=$(($(grep $GREP_OPTS $HEADER_END_STRING $file | cut -f 1 -d:) + 2))
    tail $file --lines=+$HEADER | cut -d' ' -f1,5 | awk -F '[ :]' '{print $2" "$4}'  > $DIR_NAME/temp.txt
    # | cut -d':' -f2,3
done
