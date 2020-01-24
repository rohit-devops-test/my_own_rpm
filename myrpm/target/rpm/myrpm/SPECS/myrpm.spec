%define _unpackaged_files_terminate_build 0
%define __jar_repack 0
Name: myrpm
Version: 1.0.0
Release: 1
Summary: myrpm
License: Jain Co.PVT LTD 2020
Distribution: Trash 2020
Group: Application/Collectors
Packager: R1A2C
autoprov: yes
autoreq: yes
Prefix: /usr/local
BuildArch: noarch
BuildRoot: /root/my_rpm/myrpm/target/rpm/myrpm/buildroot

%description
Jain Package

%install

if [ -d $RPM_BUILD_ROOT ];
then
  mv /root/my_rpm/myrpm/target/rpm/myrpm/tmp-buildroot/* $RPM_BUILD_ROOT
else
  mv /root/my_rpm/myrpm/target/rpm/myrpm/tmp-buildroot $RPM_BUILD_ROOT
fi

%files

%attr(755,rohit,rohit) "/jain/product_sun_shine/bin"
%doc %attr(755,rohit,rohit) "/jain/product_sun_shine/etc"
%doc %attr(755,rohit,rohit) "/jain/product_sun_shine/lib"

%pre
echo "installing myrpm now on `date`"
