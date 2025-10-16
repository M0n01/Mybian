#!/bin/bash

set_debian_unstable() {
    echo "configuring debian unstable (sid)"
    cd ansible-config || exit 1
    sudo ansible-playbook -i localhost, -c local mybian.yml --tags "unstable"
}

start_base_playbook() {
    echo "Starting playbook..."
    cd ansible-config || exit 1
    sudo ansible-playbook -i localhost, -c local mybian.yml --tags "base"
}


codename=$(cat /etc/debian_version)
if [[ "$codename" == *"sid"* ]]; then
    echo "Debian unstable detected"
    start_base_playbook
    exit 0
else
    echo "Debian unstable not found"
    read -p "Do you want to set your Debian in unstable ? (y/n) " reponse
    if [[ "$reponse" =~ ^[Yy]$ ]]; then
        set_debian_unstable
        sudo reboot
    elif [[ "$reponse" =~ ^[Nn]$ ]]; then
        echo "Debian version unchanged"
        start_base_playbook
        exit 0
    else
        echo "Uknown option, leaving..."
        exit 1
    fi
fi






# Installer Ansible si besoin
if ! command -v ansible &> /dev/null; then
    echo "Installation de Ansible..."
    sudo apt update && sudo apt install -y ansible
fi

cd ansible-config/playbooks || exit 1

# Vérifier si la machine est en unstable
if ! is_unstable; then
    echo "Machine en stable. Lancement du playbook avec bascule en unstable..."
    sudo ansible-playbook -i localhost, -c local mybian_set_unstable.yml
    echo "Redémarrage du système pour appliquer la bascule en unstable..."
    sudo reboot
else
    echo "Machine déjà en unstable. Lancement du playbook normal..."
    sudo ansible-playbook -i localhost, -c local mybian.yml
fi
