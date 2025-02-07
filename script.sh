#!/bin/bash

if ! command -v ansible &> /dev/null; then
    echo "Ansible Installation..."
    sudo apt update && sudo apt install ansible -y
fi

cd ansible-config
ansible-playbook -i localhost, -c local playbook.yml

