#!/bin/bash

# Let us wait a bit for the container's network to come alive!
sleep 30

# OS Basics & repo setup
# Note: SteamCMD requires enabling 32bit arch
dpkg --add-architecture i386
apt update
apt upgrade -y

# This allows us to Agree to license conditions from within Packer
echo steam steam/question select "I AGREE" | debconf-set-selections
echo steam steam/license note '' | debconf-set-selections

# Package installation
apt install -y software-properties-common steamcmd

echo " ---------- INSTALLING PALWORLD ------------"

steamcmd +login anonymous +app_update 1007 +quit
