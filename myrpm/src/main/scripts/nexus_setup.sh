#!/bin/bash
NEXUS_SERVICE_FILE='/etc/systemd/system/nexus.service'
if [[ ${UID} -ne 0 ]] 
then
	echo "Script must be executed as root user"
	exit 1
fi
echo -e "\t\t Stage1: Performing pre-checks \t\t \n"
echo -e "--> Installing java-1.8.0"
yum install java-1.8.0-openjdk.x86_64 -y
sleep 5
echo ""
echo -e "--> Creating nexus user\n"
USER_CHECK=$(cat /etc/passwd | grep "nexus")
if [[ -z ${USER_CHECK} ]]
then
useradd nexus
echo -e "--> Generating & Setting password\n"
PASSWORD=$(date | md5sum | cut -c 1-6)
echo "${PASSWORD}" | passwd --stdin nexus
passwd -e nexus
echo ""
echo -e "--> Giving power to nexus user\n"
sed -i '101inexus    ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers
echo ""
echo "Password must be reset after first login"
fi
echo -e "\t\t Stage2: Setting up nexus \t\t"
echo -e "--> Downloading nexus\n"
cd /opt && wget http://download.sonatype.com/nexus/3/nexus-3.19.0-01-unix.tar.gz
tar -xvf nexus-3.19.0-01-unix.tar.gz && mv nexus-3.19.0-01 nexus
chown -R nexus:nexus /opt/nexus && chown -R nexus:nexus /opt/sonatype-work
echo "--> setting nexus user to start nexus service\n"
echo "run_as_user=nexus" > /opt/nexus/bin/nexus.rc
echo "optimizing memory allocation"
sed -i 's/-Xms2703m/-Xms512m/' /opt/nexus/bin/nexus.vmoptions
sed -i 's/-Xmx2703m/-Xmx512m/' /opt/nexus/bin/nexus.vmoptions
sed -i 's/-XX:MaxDirectMemorySize=2703m/-XX:MaxDirectMemorySize=512m/' /opt/nexus/bin/nexus.vmoptions
if [[ ! -f ${NEXUS_SERVICE_FILE} ]]
then
	cat > /etc/systemd/system/nexus.service << EOF
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target
EOF
echo -e "--> Setting nexus for service\n"
ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
chkconfig --add nexus
chkconfig --levels 345 nexus on
fi
echo -e "--> Starting Nexus service\n"
service nexus start
if [[ ${?} -eq 0 ]]
then
      echo "Service started"
else
	echo "Unable to start service..Aborting"
	exit 1
fi
echo -e "\t\t Nexus Installation completed\t\t\n"
echo -e "Now switch to nexus user & reset the password. Following passwd has been set ${PASSWORD} \n"

