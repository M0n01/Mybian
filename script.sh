#!/bin/bash

# Fonction pour détecter la version Debian
is_unstable() {
    codename=$(lsb_release -c -s)
    if [[ "$codename" == "sid" ]]; then
        return 0    # true
    else
        return 1    # false
    fi
}

# Installer Ansible si besoin
if ! command -v ansible &> /dev/null; then
    echo "Installation de Ansible..."
    sudo apt update && sudo apt install -y ansible
fi

cd ansible-config/playbooks || exit 1

# Vérifier si la machine est en unstable
if ! is_unstable; then
    echo "Machine en stable. Lancement du playbook avec bascule en unstable..."
    ansible-playbook -i localhost, -c local mybian.yml -e enable_unstable=true
    echo "Redémarrage du système pour appliquer la bascule en unstable..."
    sudo reboot
else
    echo "Machine déjà en unstable. Lancement du playbook normal..."
    ansible-playbook -i localhost, -c local playbook.yml
fi
