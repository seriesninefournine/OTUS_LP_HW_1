#!/bin/bash

# Install elrepo
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/elrepo-release-7.0-5.el7.elrepo.noarch.rpm

# Install new kernel
yum install -y https://elrepo.org/linux/kernel/el7/x86_64/RPMS/kernel-lt-5.4.137-1.el7.elrepo.x86_64.rpm

# Remove older kernels (Only for demo! Not Production!)
#rm -f /boot/*3.10*

# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."

# Reboot VM
shutdown -r now