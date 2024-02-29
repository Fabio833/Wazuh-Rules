#!/bin/bash

# Detect the OS
OS=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

#SIEM Ubuntu
if [[ $OS == *"Ubuntu"* ]]; then
#wazuh

#SIEM CentOS/Redhat

elif [[ $OS == *"Red Hat"* ]]; then
#wazuh



# Ubuntu 20.04 & 22.04
if [[ $OS == *"Ubuntu"* ]]; then
    wget -q https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install sysmonforlinux -y

# Debian 11
elif [[ $OS == *"Debian"* ]]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
    sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
    wget -q https://packages.microsoft.com/config/debian/11/prod.list
    sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
    sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
    sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
    sudo apt-get update
    sudo apt-get install apt-transport-https -y
    sudo apt-get update
    sudo apt-get install sysmonforlinux -y

# Fedora 36
elif [[ $OS == *"Fedora"* ]]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo wget -q -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/fedora/36/prod.repo
    sudo dnf install sysmonforlinux

# RHEL 8
elif [[ $OS == *"Red Hat"* ]]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo wget -q -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/rhel/8/prod.repo
    sudo dnf install sysmonforlinux

# RHEL 9
elif [[ $OS == *"Red Hat"* ]]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo wget -q -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/rhel/9.0/prod.repo
    sudo dnf install sysmonforlinux

# openSUSE 15
elif [[ $OS == *"openSUSE"* ]]; then
    sudo zypper install libicu
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    wget -q https://packages.microsoft.com/config/opensuse/15/prod.repo
    sudo mv prod.repo /etc/zypp/repos.d/microsoft-prod.repo
    sudo chown root:root /etc/zypp/repos.d/microsoft-prod.repo
    sudo zypper install sysmonforlinux

# SLES 15
elif [[ $OS == *"SLES"* ]]; then
    sudo rpm -Uvh https://packages.microsoft.com/config/sles/15/packages-microsoft-prod.rpm
    sudo zypper install sysmonforlinux

else
    echo "Unsupported OS"
    exit 1
fi

# Install Sysmon
sudo sysmon -i

#configuração sysmon
sudo mv /opt/sysmon/config.xml /opt/sysmon/config.xml.old
sudo wget -O /opt/sysmon/config.xml https://raw.githubusercontent.com/Fabio833/Wazuh-Rules/main/Sysmon%20Linux/config/collect-all.xml
sudo sysmon -c /opt/sysmon/config.xml