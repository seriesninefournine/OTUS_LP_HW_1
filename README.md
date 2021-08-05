# Домашняя работа №1 курса Otus Linux.Professional
## Обновить ядро в базовой системе

Vagrant скрипт использует провайдера виртуализации VirtualBox 6.1.22 и предназначен для развертывания виртуальной машины с характеристиками:
RAM: 1Gb 
CPU: 2 core

Характеристики контейнера series949/centos-5-4-137
ОС: Centos 7
HDD: 40Gb
Базовый образ: CentOS-7-x86_64-Minimal-2009.iso
Kernel: kernel-lt-5.4.137-1.el7.elrepo
Установлено дополнение: VBoxGuestAdditions 6.1.22
Проброс папок: ./node_01_sync <--> /home/vagrant/node_01_sync
обновления пакетов актуальные на 2021-08-04
