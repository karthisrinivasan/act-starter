#!/bin/sh

echo "Generate truth files from current project state"
echo "(use only if output is correct for a certain test)"
echo "test directory name: "
read test_dir_name

if [ -d $test_dir_name ]
then

    cd "$test_dir_name"
    i=test.act
    j=test
    k=test.actsim

    # simulate 
    actsim $i $j < $k > temp.out 2>/dev/null

    if [ $? -eq 0 ] 
    then
        sed 's/\[.*\]//g' temp.out > temp.processed
        mv temp.processed test.truth
        rm temp.out
        echo "test.truth updated successfully"
    else
        echo "actsim unnatural exit, truth not updated!"
        exit 1
    fi

else
    echo "test does not exist!"
    exit 1
fi