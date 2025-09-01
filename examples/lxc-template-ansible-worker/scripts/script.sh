#!/bin/bash

ANSIBLE_PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVOx952kWl+i76MLNKW56EG5Nee+xQ1HkEYOHvq6RL0 ansible@workload"

# Let us wait a bit for the container's network to come alive!
sleep 30

# OS Basics
apt update
apt upgrade -y

apt install -y openssh-server

# Create the Ansible user automatically
sudo adduser --disabled-password --gecos "Ansible Automation User,,," ansible
sudo usermod -aG sudo ansible
echo 'ansible ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/ansible
sudo chmod 440 /etc/sudoers.d/ansible

# Set up the accepted public key for the ansible user
mkdir -p /home/ansible/.ssh
mv /tmp/ansible-key.pub /home/ansible/.ssh/authorized_keys
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh

# SSH Hardening

# Uncomment to disable password auth
# sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
# Uncomment to disable root login
# sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

# Allow only the ansible user and only via public key auth
if ! grep -q '^AllowUsers ansible' /etc/ssh/sshd_config; then
  echo 'AllowUsers ansible' >> /etc/ssh/sshd_config
fi
if ! grep -q '^Match User ansible' /etc/ssh/sshd_config; then
  cat <<EOF >> /etc/ssh/sshd_config

Match User ansible
    AuthenticationMethods publickey
    PermitRootLogin no
EOF
fi
