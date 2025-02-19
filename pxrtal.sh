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
echo "\"Have a nice day!\""
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
echo "10) Check Drivers"
echo "11) Sound Settings"
echo "-------------------------"
echo "12) Pxrtal OS Website"
echo "13) Pxrtal OS Github"
echo "14) About"
echo "15) Help"
echo "16) Exit"
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
  10)
    echo "Checking Drivers:"
    sudo lshw -C display
    ;;
  11)
    echo "Sound Settings:"
    alsamixer
    ;;
  -------------------------
  12)
    echo "Opening Pxrtal OS Website..."
    xdg-open "https://www.pxrtallinux.org" 2>/dev/null || echo "Unable to open web browser."
    ;;
  13)
    echo "Opening Pxrtal OS Github page..."
    xdg-open "https://github.com/root0emir" 2>/dev/null || echo "Unable to open web browser."
    ;;
  14)
    echo "For information about Pxrtal OS, type 'about' in the terminal."
    ;;
  15)
    echo "For help with Pxrtal OS, type 'help' in the terminal."
    ;;
  16)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid option."
    ;;
esac
``` ▋