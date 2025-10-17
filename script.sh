#!/usr/bin/env bash

#    ░███     ░███            ░██        ░██                      
#    ░████   ░████            ░██                                 
#    ░██░██ ░██░██ ░██    ░██ ░████████  ░██ ░██████   ░████████  
#    ░██ ░████ ░██ ░██    ░██ ░██    ░██ ░██      ░██  ░██    ░██ 
#    ░██  ░██  ░██ ░██    ░██ ░██    ░██ ░██ ░███████  ░██    ░██ 
#    ░██       ░██ ░██   ░███ ░███   ░██ ░██░██   ░██  ░██    ░██ 
#    ░██       ░██  ░█████░██ ░██░█████  ░██ ░█████░██ ░██    ░██ 
#                         ░██                                     
#                   ░███████                                      
#     

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_title() {
    local title="$1"
    local length=${#title}
    local border=$(printf '%*s' "$length" | tr ' ' '=')
    echo -e "${BLUE}╭─${border}─╮${NC}"
    echo -e "${BLUE}│ ${title} │${NC}"
    echo -e "${BLUE}╰─${border}─╯${NC}"
}

print_color() {
    local sentence="$1"
    printf "  ${YELLOW}%-20s${NC} \n" "$sentence"
}

print_color_ok() {
    local sentence="$1"
    printf "  ${GREEN}%-20s${NC} \n" "$sentence"
}

print_color_error() {
    local sentence="$1"
    printf "  ${RED}%-20s${NC} \n" "$sentence"
}

print_title "Welcome to Mybian !"

set_debian_unstable() {
    print_color "configuring debian unstable (sid)"
    cd ansible-config || exit 1
    sudo ansible-playbook -i localhost, -c local mybian.yml --tags "unstable"
}

start_base_playbook() {
    print_color "Starting playbook..."
    cd ansible-config || exit 1
    sudo ansible-playbook -i localhost, -c local mybian.yml --tags "base"
}

codename=$(cat /etc/debian_version)
if [[ "$codename" == *"sid"* ]]; then
    print_color_ok "Debian unstable detected"
    start_base_playbook
    exit 0
else
    print_color "Debian unstable not found"
    read -p "Do you want to set your Debian in unstable ? (y/n) " reponse
    if [[ "$reponse" =~ ^[Yy]$ ]]; then
        set_debian_unstable
        sudo reboot
    elif [[ "$reponse" =~ ^[Nn]$ ]]; then
        print_color "Debian version unchanged"
        start_base_playbook
        exit 0
    else
        print_color_error "Uknown option, leaving..."
        exit 1
    fi
fi
