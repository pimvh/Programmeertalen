#!/bin/bash

DIR_NAME="hc-logs"
FILE_PREFIX="final"
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

if [ ! -e "$DIR_NAME" ]       # Check if dir exists.
then
    echo "$DIR_NAME does not exit, please run ./hc_experiments.sh first."
    exit 1
fi

FILES=$(find $DIR_NAME -name "$FILE_EXTENSION")

for file in $FILES
do
    # find 'Knapsack' in file, and start reading from the line below it.
    HEADER=$(($(grep $GREP_OPTS $HEADER_END_STRING $file | cut -f 1 -d:) + 2))
    tail $file --lines=+$HEADER | cut -d' ' -f1,5 | awk -F '[ :]' '{print $2" "$4}'  > $DIR_NAME/cleaned.txt

    # build new file name
    PARAM=$(echo $file | echo $(cut -d'-' -f3))
    AVG_FILE_NAME="final-$PARAM.dat"

    # find the final value in cleaned file
    tail $DIR_NAME/cleaned.txt --lines=2 | awk -F" " '{print $2}' | head -1 >> $DIR_NAME/$AVG_FILE_NAME

    # update the original file
    cat $DIR_NAME/cleaned.txt > $file
done

# remove last temporary file
rm $DIR_NAME/cleaned.txt
