#!/bin/sh

process_name="test"

for subdir in ./*/
do
    if [ -d $subdir ]
    then
        cd "$subdir"
        if [ -f "$process_name.processed" ] 
        then
            rm $process_name.processed
        fi
        if [ -f "$process_name.stdout" ] 
        then
            rm $process_name.stdout
        fi
        if [ -f "$process_name.stderr" ] 
        then
            rm $process_name.stderr
        fi
        if [ -f ".actsim_history" ] 
        then
            rm .actsim_history
        fi
        cd ..
    fi
done

echo "All tests cleaned."
echo