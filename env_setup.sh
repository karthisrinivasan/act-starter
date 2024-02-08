#! /bin/sh

# This needs to be called with source!
# Executing this script will not work!
# You cannot export from within a sub-shell

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SRC_DIR=$SCRIPT_DIR/src

found=0

IFS=':'
for elem in $ACT_PATH
do
    if [[ "$elem" == "$SRC_DIR" ]]; then
        found=1
    fi
done

if [ $found -ne 1 ]
then
    export ACT_PATH=$SRC_DIR:$ACT_PATH
fi
