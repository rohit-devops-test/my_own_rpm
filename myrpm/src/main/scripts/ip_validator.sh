#!/bin/bash
LOGFILE='/var/log/validator.log'
DATE=$(/usr/bin/date +%D_%T)
IPFILE='/tmp/ip.txt'
log(){
if [[ ${1} = "-p" ]]
then
	shift 1
	echo -e "${DATE} --> ${*}" >> ${LOGFILE}
else
	echo -e "\n${DATE} --> ${*}" | tee -a ${LOGFILE}
fi


}
while true;
do
read -p "Enter a ip: " IP
log -p "Entered ip ${IP}"
echo "${IP}" > ${IPFILE}
OCT1=$(cat ${IPFILE} | awk -F "." '{print $1}')
OCT2=$(cat ${IPFILE} | awk -F "." '{print $2}')
OCT3=$(cat ${IPFILE} | awk -F "." '{print $3}')
OCT4=$(cat ${IPFILE} | awk -F "." '{print $4}')
REGEX_IP='^[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}$'
if [[ ${IP} =~ ${REGEX_IP} ]]
then
    if [[ ${OCT1} -gt 255 || ${OCT2} -gt 255 || ${OCT3} -gt 255 || ${OCT4} -gt 255 ]]
        then
        log "Please enter a valid ip"
        continue
        
    else
	    log "Valid ip.IP can be used in production server operation."
    fi

break
else
        log "Please enter a valid ip"
        continue
fi
done
rm -rf ${IPFILE}
