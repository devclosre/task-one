#!/bin/bash

# Update the package repository
sudo apt update

# Install software-properties-common to add the Ansible PPA
sudo apt install -y software-properties-common

# Add the Ansible PPA (Personal Package Archive)
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install -y ansible

# Verify the installation
ansible --version






