#!/bin/bash

echo "[[ Linux User Manager ]]"
read -p "What do you want? [add/del]: " cmd
read -p "Enter the username: " user_name

case $cmd in
    "add"|"Add"|"ADD" )
        sudo adduser $user_name

        read -p "Wanna add ${user_name} to SUDO? [y/n]: " yn
        if [[ "$yn" == "y" ]]; then
            sudo usermod -aG sudo $user_name
			sudo echo "${user_name} ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers >/dev/null
        fi
        ;;
    "del"|"Del"|"DEL" )
        sudo deluser $user_name

        read -p "Wanna remove ${user_name} directory? [y/n]: " yn
        if [[ "$yn" == "y" ]]; then
            sudo rm -r /home/$user_name
        fi
        ;;
    * )
        echo "Bye bye!"
        ;;
esac

exit 0
