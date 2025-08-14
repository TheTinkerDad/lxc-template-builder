#! /bin/bash

function install_for_debian() {

  apt update
  apt upgrade -y
  apt install -y gpg wget

  if [ ! -f /usr/share/keyrings/hashicorp-archive-keyring.gpg ]; then
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update
  fi

  apt install -y packer lxc
  packer plugins install github.com/hashicorp/lxc
}

function install_for_centos() {
  echo CentOS is not yet supported.
}

function install_for_alpine() {
  echo Alpine is not yet supported.
}

OS_GUESS="Unknown"
if [ ! -z $(which yum) ]; then
  OS_GUESS="CentOS"
elif [ ! -z $(which apt) ]; then
  OS_GUESS="Debian"
elif [ ! -z $(which apk) ]; then
  OS_GUESS="Alpine"
fi

echo "Detected OS '$OS_GUESS'"

case "$OS_GUESS" in
  CentOS)
    install_for_centos
    exit
    ;;
  Debian)
    install_for_debian
    exit
    ;;
  Alpine)
    install_for_alpine
    exit
    ;;
  Unknown)
    echo Sorry, unsupported Linux distro. Feel free to open a GitHub ticket!
    exit
    ;;
esac
