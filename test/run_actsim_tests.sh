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

myecho " "
num=0
lim=10
count=0

for subdir in ./*/
do
	# echo "hi"
	if [ -d $subdir ]; then
		cd "$subdir"
		i=test.act
		j=test
		k=test.actsim
		l=test.truth

		if [ $num -lt 10 ]
		then
			myecho ".[0$num]"
		else
			myecho ".[$num]"
		fi

		count=`expr $count + 1`
		num=`expr $num + 1`

		# simulate 
		actsim $i $j < $k > $j.stdout 2> $j.stderr

		# process actsim output - TODO
        sed -i '' 's/\[.*\]//g' $j.stdout

		ok=1
		# test against truth - TODO 
		# add option to cleanup sim outputs - TODO
		if ! cmp $j.stdout $l >/dev/null 2>/dev/null
		then
			echo 
			myecho "** FAILED TEST $subdir/$i: stdout"
			fail=`expr $fail + 1`
			ok=0
		fi

		if [ $ok -eq 1 ]
		then
			if [ $num -eq $lim ]
			then
				echo 
				myecho " "
				num=0
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