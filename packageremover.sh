#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 


remove_package() {
    read -p "Enter the package name to remove: " package_name

    if dpkg -l | grep -q "^ii  $package_name "; then
        echo -e "${BLUE}Package $package_name is installed.${NC}"
        read -p "Are you sure you want to remove $package_name? (y/n): " confirm
        if [ "$confirm" == "y" ]; then
            sudo apt remove -y $package_name
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Package $package_name removed successfully.${NC}"
                sudo apt autoremove -y
                sudo apt clean
            else
                echo -e "${RED}Failed to remove package $package_name.${NC}"
            fi
        else
            echo -e "${GREEN}Package $package_name removal canceled.${NC}"
        fi
    else
        echo -e "${RED}Package $package_name is not installed.${NC}"
    fi
}


list_installed_packages() {
    echo -e "${BLUE}Listing installed packages...${NC}"
    dpkg -l | less
}


search_package() {
    read -p "Enter the package name to search: " package_name
    echo -e "${BLUE}Searching for package $package_name...${NC}"
    apt search $package_name
}


show_package_info() {
    read -p "Enter the package name to show info: " package_name
    echo -e "${BLUE}Showing information for package $package_name...${NC}"
    apt show $package_name
}


while true; do
    echo -e "${BLUE} Package Manager Menu:${NC}"
    echo "1. List Installed Packages"
    echo "2. Search for a Package"
    echo "3. Show Package Information"
    echo "4. Remove a Package"
    echo "5. Exit"
    read -p "Select an option [1-5]: " option

    case $option in
        1) list_installed_packages ;;
        2) search_package ;;
        3) show_package_info ;;
        4) remove_package ;;
        5) break ;;
        *) echo -e "${RED}Invalid option. Please select a number between 1 and 5.${NC}" ;;
    esac
done