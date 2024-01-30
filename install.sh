#! /bin/bash

function install_for_debian() {

  apt update
  apt upgrade
  apt install -y gpg wget

  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | te>
  apt update
  apt install packer

  packer version
  packer init
  packer plugins install github.com/hashicorp/lxc
}

function install_for_centos() {
  echo CentOS is not yet supported.
}

function install_for_alpine() {
  echo Alpine is not yet supported.
}

OS_GUESS=$(which yum >/dev/null 2>&1 && echo CentOS \
        || which apt >/dev/null 2>&1 && echo Debian \
        || which apk >/dev/null 2>&1 && echo Alpine \
        || echo Unknown)

case $OS_GUESS
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
