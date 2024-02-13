#!/bin/sh

echo
echo "***********************************************************"
echo "*                 Testing with actsim                     *"
echo "***********************************************************"
echo

txtgreen='\e[32m'
txtred="\e[31m"
txtbold="\e[1m"
txtreset="\e[0m"

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

		# simulate
		actsim $fn_actfile $process_name < $fn_actsim_script > $process_name.stdout 2> $process_name.stderr

		# strip timing info from log
        sed 's/\[ *[0-9]*\]//g' $process_name.stdout > $process_name.processed

		count=`expr $count + 1`
		num=`expr $num + 1`

		# test whether output matches ground truth and report
		ok=1
		if ! cmp $process_name.processed $process_name.truth >/dev/null 2>/dev/null
		then
			myecho "** ${txtred}FAILED TEST${txtreset} $subdir$fn_actfile: stdout mismatch"
			echo
			if [ ${ACT_TEST_VERBOSE} -eq 1 ]; then
				echo "${txtbold}stdout:${txtreset}"
				cat $process_name.processed
				echo "${txtbold}truth:${txtreset}"
				cat $process_name.truth
				echo "${txtbold}stderr:${txtreset}"
				cat $process_name.stderr
			fi
			fail=`expr $fail + 1`
			ok=0
		fi

		if [ $ok -eq 1 ]
		then
			if [ $num -eq $lim ]
			then
				echo 
				myecho " "
			fi
		else
			echo " **"
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
		echo "--- ${txtred}1 test failed.${txtreset} ---"
	else
		echo "--- ${txtred}$fail tests failed.${txtreset} ---"
	fi
	exit 1
else
	echo
	echo "--- ${txtgreen}All tests passed.${txtreset} ---"
fi
echo
