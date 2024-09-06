#!/bin/bash

local_ip=$(hostname -I | awk '{print $1}')


# Get playbook from Github
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/playbook.yml
https://github.com/emiakia/aws_components_ec2_postgres_install_and_ha.git


# Define the path to your Ansible playbook
PLAYBOOK_PATH="./playbook.yml"

# Update the system
echo "Updating system..."
sudo yum update -y

# Install Ansible
echo "Installing Ansible..."
sudo yum install -y ansible

# Verify Ansible installation
echo "Verifying Ansible installation..."
ansible --version

# Run the Ansible playbook
echo "Running Ansible playbook..."
ansible-playbook "$PLAYBOOK_PATH"
