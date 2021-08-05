#!/bin/bash

#Устанавливаем нужное ПО
yum install -y epel-release 
yum install -y centos-release-scl
#yum groupinstall -y "Development Tools"

#удаляем остатки старого ядра
yum -y remove kernel.x86_64 kernel-tools.x86_64 kernel-tools-libs.x86_64 kernel-headers.x86_64 kernel-debug-devel.x86_64 

#Устанавливаем нужные модули для компиляции VBoxGuestAdditions
#yum --disablerepo=\* --enablerepo=elrepo-kernel install -y kernel-lt-devel kernel-lt-headers kernel-lt-t*
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-devel-5.4.137-1.el7.elrepo.x86_64.rpm
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-headers-5.4.137-1.el7.elrepo.x86_64.rpm
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-tools-5.4.137-1.el7.elrepo.x86_64.rpm
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-tools-libs-5.4.137-1.el7.elrepo.x86_64.rpm
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-tools-libs-devel-5.4.137-1.el7.elrepo.x86_64.rpm
yum install -y bzip2 tar make perl devtoolset-7 dkms openssl-devel ncurses-devel flex bison
#scl enable devtoolset-7 bash

#Восстанавливаем недостающие файлы
cd /usr/src/kernels/
curl -O https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.137.tar.gz
tar -xf linux-5.4.137.tar.gz
rm -f linux-5.4.137.tar.gz
cp -n -r ./linux-5.4.137/. ./5.4.137-1.el7.elrepo.x86_64/

#Подготвливаем исходники ядра к установке VBoxGuestAdditions
cd /usr/src/kernels/5.4.137-1.el7.elrepo.x86_64
make oldconfig
make prepare

#Устанавливаем VBoxGuestAdditions
mkdir /tmp/VBox
cd /tmp/VBox
#VBoxVersion=$(curl http://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT)
VBoxVersion=6.1.22
curl -O http://download.virtualbox.org/virtualbox/$VBoxVersion/VBoxGuestAdditions_$VBoxVersion.iso
mkdir /media/iso
mount VBoxGuestAdditions_$VBoxVersion.iso /media/iso
/media/iso/VBoxLinuxAdditions.run
umount /media/iso
rm -f VBoxGuestAdditions_$VBoxVersion.iso

#Чистим за собой
yum remove -y kernel-lt-devel-5.4.137-1.el7.elrepo.x86_64 kernel-lt-headers-5.4.137-1.el7.elrepo.x86_64 kernel-lt-tools-5.4.137-1.el7.elrepo.x86_64
yum remove -y kernel-lt-tools-libs-5.4.137-1.el7.elrepo.x86_64 kernel-lt-tools-libs-devel-5.4.137-1.el7.elrepo.x86_64
yum remove -y bzip2 tar make perl devtoolset-7 dkms openssl-devel ncurses-devel flex bison
yum autoremove -y
rm -rf /usr/src/kernels/5.4.137-1.el7.elrepo.x86_64
rm -rf /usr/src/kernels/linux-5.4.137
