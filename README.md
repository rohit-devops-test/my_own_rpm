# my_own_rpm
RedHat Package Manager(RPM) is generated with help of Maven.
How to generate rpm:-
>> mvn clean install
Note:- RPM will be generated in target forlder :- target/rpm/myrpm/RPMS/noarch/myrpm-1.0.0-1.noarch.rpm 
How to install:-
You can use rpm command to install.
*************************** Installing New Rpm **********************************************
[root@ip-172-31-90-157 ~]# rpm -ivh /root/my_rpm/myrpm/target/rpm/myrpm/RPMS/noarch/myrpm-1.0.0-1.noarch.rpm
Preparing...                          ################################# [100%]
installing myrpm now on Fri Jan 24 02:33:03 UTC 2020
Updating / installing...
   1:myrpm-1.0.0-1                    ################################# [100%]
[root@ip-172-31-90-157 ~]#
[root@ip-172-31-90-157 ~]#
[root@ip-172-31-90-157 ~]# cd /jain/product_sun_shine/
bin/ etc/ lib/
[root@ip-172-31-90-157 ~]#
[root@ip-172-31-90-157 ~]#
[root@ip-172-31-90-157 ~]# ls /jain/product_sun_shine/bin/
ip_validator.sh  otp_generator.sh
[root@ip-172-31-90-157 ~]#
***********************************************************************************************
How to fetch details:-
[root@ip-172-31-90-157 bin]# rpm -qi myrpm-1.0.0-1
Name        : myrpm
Version     : 1.0.0
Release     : 1
Architecture: noarch
Install Date: Fri 24 Jan 2020 02:27:33 AM UTC
Group       : Application/Collectors
Size        : 2492
License     : Jain Co.PVT LTD 2020
Signature   : (none)
Source RPM  : myrpm-1.0.0-1.src.rpm
Build Date  : Fri 24 Jan 2020 02:27:09 AM UTC
Build Host  : ip-172-31-90-157.ec2.internal
Relocations : /usr/local
Packager    : R1A2C
Summary     : myrpm
Description :
Jain Package
*************************************************************************************************
