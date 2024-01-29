#!/bin/bash

# Let us wait a bit for the container's network to come alive!
sleep 30

# OS Basics
apt update
apt upgrade

# Install JDK and Wget
apt install -y wget openjdk-17-jdk-headless

# Actual Minecraft server installation
pwd
mkdir minecraft
cd minecraft
wget https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.0/fabric-installer-1.0.0.jar
java -jar fabric-installer-1.0.0.jar server -mcversion 1.20.4 -downloadMinecraft
