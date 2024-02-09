#!/bin/sh

echo
echo "***********************************************************"
echo "*                 Testing with actsim                     *"
echo "***********************************************************"
echo

check_echo=0
myecho()
{
  if [ $check_echo -eq 0 ]
  then
    check_echo=1
    count=`echo -n "" | wc -c | awk '{print $1}'`
    if [ $count -gt 0 ]
    then
        check_echo=2
    fi
  fi
  if [ $check_echo -eq 1 ]
  then
    echo -n "$@"
  else
    echo "$@\c"
  fi
}

fail=0
count=0

myecho " "
num=0
lim=10

fn_actfile="test.act"
process_name="test"
fn_actsim_script="test.actsim"

for subdir in ./*/
do
    if [ -d $subdir ]; then
        cd "$subdir"

        if [ $num -lt 10 ]
        then
            myecho ".[0$num]"
        else
            myecho ".[$num]"
        fi
        
        num=`expr $num + 1`
        count=`expr $count + 1`

        ok=1

        # simulate
        actsim $fn_actfile $process_name < $fn_actsim_script > $process_name.stdout 2> $process_name.stderr

        # check if actsim exited abnormally
        if [ $? -ne 0 ];
        then
            echo
            myecho "** FAILED TEST $subdir$fn_actfile: abnormal simulator exit **"
            fail=`expr $fail + 1`
            ok=0
        fi

        # check regression tests
        if [ $ok -eq 1 ] && [ -f "$process_name.truth" ]; 
        then

            # strip timing from test output
            sed 's/\[.*\]//g' $process_name.stdout > $process_name.processed

            if ! cmp $process_name.processed $process_name.truth >/dev/null 2>/dev/null
            then
                echo 
                myecho "** FAILED REGRESSION TEST $subdir$fn_actfile: stdout mismatch"
                fail=`expr $fail + 1`
                ok=0
            fi
        fi

        # set the seperator tokens to only newline, so we an iterate over grep output
        oldifs=$IFS
        IFS=$'\n'

        # check if there are any test failures reported in the sim log and report
        for line in $(grep "TEST FAILED" "$process_name.stdout")
        do
            echo
            myecho "** FAILED TEST $subdir$fn_actfile: $(echo $line | sed 's/\[.*TEST FAILED ([[:digit:]]*): //g') **"
            num=0
            fail=`expr $fail + 1`
            ok=0
        done

        # reset the seperator tokens
        IFS=$oldifs

        if [ $ok -eq 1 ]
        then
            if [ $num -eq $lim ]
            then
                echo 
                myecho " "
                num=0
            fi
        else
            echo
            echo
            myecho " "
            num=0
        fi
        cd ..
    fi
done

if [ $num -ne 0 ]
then
    echo
fi

if [ $fail -ne 0 ]
then
    if [ $fail -eq 1 ]
    then
        echo "--- Summary: 1 test failed ---"
    else
        echo "--- Summary: $fail tests failed ---"
    fi
    exit 1
else
    echo
    echo "SUCCESS! All tests passed."
fi
echo
