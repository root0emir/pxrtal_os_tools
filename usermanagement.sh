#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 


add_user() {
    read -p "Enter username: " username
    read -s -p "Enter password: " password
    echo
    sudo useradd -m -p $(openssl passwd -1 $password) $username
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User $username added successfully.${NC}"
    else
        echo -e "${RED}Failed to add user $username.${NC}"
    fi
}


delete_user() {
    read -p "Enter username to delete: " username
    sudo userdel -r $username
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User $username deleted successfully.${NC}"
    else
        echo -e "${RED}Failed to delete user $username.${NC}"
    fi
}


grant_sudo() {
    read -p "Enter username to grant sudo privileges: " username
    sudo usermod -aG sudo $username
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User $username granted sudo privileges.${NC}"
    else
        echo -e "${RED}Failed to grant sudo privileges to user $username.${NC}"
    fi
}


monitor_user_activity() {
    read -p "Enter username to monitor: " username
    last $username
}


while true; do
    echo -e "${BLUE}User Management Menu:${NC}"
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Grant Sudo Privileges"
    echo "4. Monitor User Activity"
    echo "5. Exit"
    read -p "Select an option [1-5]: " option

    case $option in
        1) add_user ;;
        2) delete_user ;;
        3) grant_sudo ;;
        4) monitor_user_activity ;;
        5) break ;;
        *) echo -e "${RED}Invalid option. Please select a number between 1 and 5.${NC}" ;;
    esac
done