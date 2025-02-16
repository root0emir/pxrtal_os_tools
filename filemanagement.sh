#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 


search_files() {
    read -p "Enter directory to search in: " directory
    read -p "Enter search term: " search_term
    if [ -d "$directory" ]; then
        echo -e "${BLUE}Searching for '$search_term' in '$directory'...${NC}"
        find "$directory" -name "*$search_term*"
    else
        echo -e "${RED}Directory '$directory' does not exist.${NC}"
    fi
}


sort_files() {
    read -p "Enter directory to sort: " directory
    if [ -d "$directory" ]; then
        echo -e "${BLUE}Sorting files in '$directory'...${NC}"
        echo "1. By Name"
        echo "2. By Size"
        echo "3. By Modification Date"
        read -p "Select a sorting option [1-3]: " sort_option

        case $sort_option in
            1) ls -l "$directory" | sort -k 9 ;;
            2) ls -lS "$directory" ;;
            3) ls -lt "$directory" ;;
            *) echo -e "${RED}Invalid option. Please select a number between 1 and 3.${NC}" ;;
        esac
    else
        echo -e "${RED}Directory '$directory' does not exist.${NC}"
    fi
}


change_permissions() {
    read -p "Enter file/directory path: " path
    if [ -e "$path" ]; then
        echo -e "${BLUE}Current permissions for '$path':${NC}"
        ls -l "$path"
        read -p "Enter new permissions (e.g., 755): " permissions
        chmod "$permissions" "$path"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Permissions changed successfully.${NC}"
        else
            echo -e "${RED}Failed to change permissions.${NC}"
        fi
    else
        echo -e "${RED}File or directory '$path' does not exist.${NC}"
    fi
}


while true; do
    echo -e "${BLUE}File and Directory Management Menu:${NC}"
    echo "1. Search Files"
    echo "2. Sort Files"
    echo "3. Change Permissions"
    echo "4. Exit"
    read -p "Select an option [1-4]: " option

    case $option in
        1) search_files ;;
        2) sort_files ;;
        3) change_permissions ;;
        4) break ;;
        *) echo -e "${RED}Invalid option. Please select a number between 1 and 4.${NC}" ;;
    esac
done