#!/bin/sh

# Change root pasword to be vagrant
echo "vagrant" | passwd --stdin root

# Create a Vagrant User
useradd -G wheel -u 501 vagrant
echo "vagrant" | passwd --stdin vagrant

# Configure SSH access with insecure keypair
mkdir -m 0700 -p /home/vagrant/.ssh
curl -o /home/vagrant/.ssh/authorized_keys -kL 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# SSH Tweaks
echo "UseDNS no" >> /etc/ssh/sshd_config

# Configure password-less SUDO
echo "vagrant"$'\t'"ALL=(ALL)"$'\t'"NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sed -i "s/^.*requiretty/#Defaults   requiretty/" /etc/sudoers
