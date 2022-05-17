#!/bin/bash


VKernel=5.4.193-1.el7.elrepo.x86_64

#Устанавливаем нужное ПО
yum install -y epel-release 
yum install -y centos-release-scl
#yum groupinstall -y "Development Tools"

#удаляем остатки старого ядра
yum -y remove kernel.x86_64 kernel-{tools.x86_64,tools-libs.x86_64,headers.x86_64,debug-devel.x86_64} 

#Устанавливаем нужные модули для компиляции VBoxGuestAdditions
#yum --disablerepo=\* --enablerepo=elrepo-kernel install -y kernel-lt-devel kernel-lt-headers kernel-lt-t*
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-{devel,headers,tools,tools-libs,tools-libs-devel}-$VKernel.rpm
yum install -y bzip2 tar make perl devtoolset-7 dkms openssl-devel ncurses-devel flex bison
#scl enable devtoolset-7 bash

#Восстанавливаем недостающие файлы
cd /usr/src/kernels/
curl -O https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.193.tar.gz
tar -xf linux-5.4.193.tar.gz
rm -f linux-5.4.193.tar.gz
cp -n -r ./linux-5.4.193/. ./$VKernel/

#Подготвливаем исходники ядра к установке VBoxGuestAdditions
cd /usr/src/kernels/$VKernel
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
yum remove -y kernel-lt-{devel,headers,tools,tools-libs,tools-libs-devel}-$VKernel 
yum remove -y bzip2 tar make perl devtoolset-7 dkms openssl-devel ncurses-devel flex bison
yum autoremove -y
rm -rf /usr/src/kernels/$VKernel
rm -rf /usr/src/kernels/linux-5.4.193
