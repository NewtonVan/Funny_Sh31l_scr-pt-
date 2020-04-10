#!/bin/bash
if [ -n "$1" ]; then
    let "HALF_FILE=$(find $1 -type f | wc -l) / 2"
    # echo $HALF_FILE
    find $1 -not -name "$(basename $0)" -type f -print0 | shuf -z -n${HALF_FILE} | xargs -0 ls -l
    # find $1 -not -name "$0" -type f -print0 | shuf -z -n${HALF_FILE} | xargs -0 ls -l
else
     echo "This is infinitely xjbs mode, enter the directory u wanna start, type q to quit>"
     while true; do
         read  DIR 
         eval DIR=$DIR
         set ${DIR}
         if [ "$1" = "quit" -o "$1" = "Q" -o "$1" = "q" ]; then
             exit 0
         fi
         if [ -d "$1" ]; then
             let "HALF_FILE=$(find $1 -type f | wc -l) / 2"
             find $1 -not -name "$(basename $0)"  -type f -print0 | shuf -z -n${HALF_FILE} | xargs -0 ls -l
         fi
     done
fi
