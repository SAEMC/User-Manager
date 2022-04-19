#!/bin/bash

echo "[[ Linux User Manager ]]"
read -p "What do you want? [Add/Del]: " cmd
read -p "Enter username: " user_name

case $cmd in
    [Aa][Dd][Dd] )
        sudo adduser $user_name

        read -p "Wanna add ${user_name} to SUDO? [Y/N]: " yn
        if [[ "$yn" == "Y" || "$yn" == "y" ]]; then
            sudo usermod -aG sudo $user_name
            echo "${user_name} ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers >/dev/null
        fi
        ;;
    [Dd][Ee][Ll] )
        sudo deluser $user_name
        sudo sed -i "/${user_name} ALL=NOPASSWD: ALL/d" /etc/sudoers

        read -p "Wanna delete ${user_name} directory? [Y/N]: " yn
        if [[ "$yn" == "Y" || "$yn" == "y" ]]; then
            sudo rm -r /home/$user_name
        fi
        ;;
    * )
        echo "Bye bye!"
        ;;
esac

exit 0
