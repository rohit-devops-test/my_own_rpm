#!/bin/bash
# Script will generate password
# function will show usage
usage () {
echo "usage: "${0}" [-v][-s] -l <length>"
echo -v verbose
echo -s special character
echo -l length of password
}
if [[ ${#} -eq 0 ]]
then
usage
exit 1
fi
LENGTH=16
while getopts vl:s OPTION
do	
	case ${OPTION} in
	v)
		VERBOSE='true'
		echo -e "\nVerbose mode is on...\n"
		;;
	l)
		LENGTH="${OPTARG}"
		;;
	s)
		USE_SPEC_CHAR='true'
		;;
	?)
		Invalid option
		usage
	esac
done
shift $(( ${OPTIND} - 1 ))

if [[ ${VERBOSE} = 'true' ]]
then
	echo -e "Generating OTP...\n"
fi
if [[ ${USE_SPEC_CHAR} = 'true' ]]
then
	SP_CHAR=$(echo '~!@#$%^&*()' | fold -w1 | shuf | head -c1)
	SP_PASSWORD=$(date +%s%N${RANDOM} | md5sum | head -c ${LENGTH})
	echo "OTP with special character is ${SP_PASSWORD}${SP_CHAR}"
else
PASSWORD=$(date +%s%N${RANDOM} | md5sum | head -c ${LENGTH})
sleep 3
echo "OTP is: ${PASSWORD}"
fi
