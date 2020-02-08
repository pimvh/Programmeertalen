#!/bin/bash

# Main.java arguments
VERBOSE=1
NR_ITEM=100
DIMENSIONS=2
SOLVER=simulated_annealing
NR_ITERATIONS=10000

NR_TO_UNPACK="TO DO select best value in found hc-average-value.pdf"
echo $NR_TO_UNPACK
echo 'not working yet.'
MAX_TEMPERATURE="0 1 10 100 1000 10000"

# Filenames
DIR_NAME="sa-logs"
FILE_PREFIX="param"

if [ $# -ne 0 ]
then
  echo "Usage: `basename $0`"
  exit $E_BADARGS
fi

ALGO_ARGUMENTS="-verbose $VERBOSE -nr_items $NR_ITEM -dimensions $DIMENSIONS -solver $SOLVER -nr_iterations $NR_ITERATIONS"

cd .. && make > /dev/null

#create directory
if [ ! -e "$DIR_NAME" ]       # Check if dir exists.
then
    echo "creating $DIR_NAME..."
    mkdir $DIR_NAME
fi

for MAX_TEMP in $MAX_TEMPERATURE
    do
    for RUN in $RUNS
        do
        echo "running temp $MAX_TEMP, run $RUN..."
        FILE_NAME="$FILE_PREFIX-$MAX_TEMP-run-$RUN-all.dat"
        java Main $ALGO_ARGUMENTS "-max_temperature $MAX_TEMP" > $DIR_NAME/$FILE_NAME
        done
    done
