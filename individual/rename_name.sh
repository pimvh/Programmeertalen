#!/bin/bash

E_BADARGS=65

if [ $# -ne 2 ]
then
  echo "Usage: `basename $0` [old-name] [new-name]"
  exit $E_BADARGS
fi

cd ..

FILES=$(find ./ -name *.java)

for file in $FILES
do
    chmod o+wr $file
    cat $file | perl -pe "s/$1/$2/sg" > $file
    echo
done

exit $?
