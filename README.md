# Mybian
Scripts and Ansible playbook to setup my debian sid

## TODO

- Setup GEF et GEF de Bata24 pour GDB
- Installation QEMU + KVM + Virtmanager : https://linuxconfig.org/setting-up-virtual-machines-with-qemu-kvm-and-virt-manager-on-debian-ubuntu
- Setup Nvim
- Setup VM (dossier de partage, coper/coller etc)
- setup venv python
- Ajouter un autoremove à la toute fin
- pour pipx, après l'install faire : pipx ensurepath
- installer Universal Radio Hacker (à voir)
- install docker (pour debian sid il faut remplacer $(. /etc/os-release && echo "$VERSION_CODENAME")
 par la dernière release debian donc Trixie car il en connais pas debian sid ou la prochaine version majeur de debian)
- regarder comment faire un UI sympas (un peu comme exegol) dans le terminal.


## Rules

From now on, ALL IN ENGLISH.

Follow best practice :
- https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html

Git commit rules: 
    - "add: ..." when adding a feature
    - "fix: ..." when fixing a bug or wrong configuration
    - "mod: ..." when modifying a process
