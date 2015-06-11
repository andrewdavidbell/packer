#!/bin/sh

# Install development tools to build guest additions
yum -y install make
yum -y install perl
yum -y install gcc
yum -y install kernel-devel

# Install guest additions
mkdir /media/VBoxGuestAdditions
mount -o loop,ro /root/VBoxGuestAdditions.iso /media/VBoxGuestAdditions
sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions

# Remove ISO and development tools
rm /root/VBoxGuestAdditions.iso
yum -y erase kernel-devel
yum -y install yum-plugin-remove-with-leaves
yum -y erase gcc --remove-leaves
yum -y erase perl --remove-leaves
yum -y erase make
yum -y erase yum-plugin-remove-with-leaves
