#! /bin/bash

# This needs to be called with source!
# Executing this script will not work!
# You cannot export from within a sub-shell

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SRC_DIR=$SCRIPT_DIR/src

found=0

IFS=':'
for elem in $ACT_PATH
do
    if [[ "$elem" == "$SRC_DIR" ]]
    then
        found=1
    fi
done

if [[ $* == *--output* ]]
then
    
    # check if the folder is already in the path
    if [ $found -eq 1 ]
    then
        echo $ACT_PATH
    else
        echo $SRC_DIR:$ACT_PATH
    fi

else
    if [ $found -ne 1 ]
    then
        export ACT_PATH=$SRC_DIR:$ACT_PATH
    fi
fi
