#!/bin/bash


cat << "EOF"

  _______   _______ _______       _         ____   _____ 
 |  __ \ \ / /  __ \__   __|/\   | |       / __ \ / ____|
 | |__) \ V /| |__) | | |  /  \  | |      | |  | | (___  
 |  ___/ > < |  _  /  | | / /\ \ | |      | |  | |\___ \ 
 | |    / . \| | \ \  | |/ ____ \| |____  | |__| |____) |
 |_|   /_/ \_\_|  \_\ |_/_/    \_\______|  \____/|_____/ 
                                                         
                                                         
EOF

echo "------------------"
echo "\"Welcome Have a nice day!\""
echo "------------------"
echo "1) Update the System"
echo "2) System Information"
echo "3) Disk Information"
echo "4) Internet Test"
echo "5) List Installed Packages"
echo "6) Show Memory Usage"
echo "7) Show CPU Information"
echo "8) List Network Connections"
echo "9) Clear Cache"
echo "-------------------------"
echo "1) PXRTAL OS Website"
echo "2) PXRTAL OS Github"
echo "3) About"
echo "4) Help"
echo ""

# Taking selection from the main menu
read -p "Please enter a choice: " choice

case $choice in
  1)
    echo "Starting System Update..."
    sudo apt update && sudo apt upgrade -y
    ;;
  2)
    echo "System Information:"
    # Fetching OS information from /etc/os-release
    if [ -f /etc/os-release ]; then
      echo -n "OS: "
      grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d \"
    else
      echo "/etc/os-release file not found."
    fi
    echo -n "Kernel: "
    uname -r
    ;;
  3)
    echo "Disk Information:"
    df -h
    ;;
  4)
    echo "Internet Test:"
    if ping -c 4 google.com > /dev/null 2>&1; then
      echo "Network connection is active."
    else
      echo "Network connection failed."
    fi
    ;;
  5)
    echo "Listing Installed Packages:"
    dpkg -l
    ;;
  6)
    echo "Memory Usage:"
    free -h
    ;;
  7)
    echo "CPU Information:"
    if command -v lscpu > /dev/null 2>&1; then
      lscpu
    else
      echo "lscpu command not found, alternative information:"
      cat /proc/cpuinfo | grep 'model name' | uniq
    fi
    ;;
  8)
    echo "Network Connections:"
    if command -v ip > /dev/null 2>&1; then
      ip a
    else
      echo "ip command not found, using ifconfig:"
      if command -v ifconfig > /dev/null 2>&1; then
        ifconfig
      else
        echo "ifconfig command also not found."
      fi
    fi
    ;;
  9)
    echo "Clearing Cache..."
    sudo sync; sudo echo 3 > /proc/sys/vm/drop_caches
    echo "Cache cleared successfully."
    ;;
  *)
    echo "Invalid option."
    ;;
esac

echo "-------------------------"
read -p "Please enter a choice from the submenu: " sub_choice

case $sub_choice in
  1)
    echo "Opening PXRTAL OS Website..."
    xdg-open "https://www.pxrtallinux.org" 2>/dev/null || echo "Unable to open web browser."
    ;;
  2)
    echo "Opening PXRTAL OS Github page..."
    xdg-open "https://github.com/root0emir" 2>/dev/null || echo "Unable to open web browser."
    ;;
  3)
    echo "For information about PXRTAL OS, type 'about' in the terminal."
    ;;
  4)
    echo "For help with PXTRAL OS, type 'help' in the terminal."
    ;;
  *)
    echo "Invalid option."
    ;;
esac