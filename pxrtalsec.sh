#!/bin/bash

echo "---------------------------------------"
echo "        Pxrtal OS Security Scanner     "
echo "---------------------------------------"
echo ""

# Function to perform a detailed security scan
function detailed_scan() {
    echo "Performing a detailed security scan..."
    sudo apt install -y clamav
    sudo freshclam
    sudo clamscan -r --bell -i /
    echo "Detailed security scan completed."
}

# Function to perform a quick security scan
function quick_scan() {
    echo "Performing a quick security scan..."
    sudo apt install -y clamav
    sudo freshclam
    sudo clamscan --bell -i /home
    echo "Quick security scan completed."
}

# Function to perform an offline security scan
function offline_scan() {
    echo "Performing an offline security scan..."
    sudo apt install -y chkrootkit
    sudo chkrootkit
    echo "Offline security scan completed."
}

# Function to perform a malware scan with Maldet
function malware_scan() {
    echo "Performing a malware scan with Maldet..."
    sudo apt install -y maldet
    sudo maldet -u
    sudo maldet -a /home
    echo "Malware scan completed."
}

# Function to perform a filesystem integrity check with AIDE
function integrity_check() {
    echo "Performing a filesystem integrity check with AIDE..."
    sudo apt install -y aide
    sudo aideinit
    sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
    sudo aide --check
    echo "Filesystem integrity check completed."
}

# Function to perform a network scan with Nmap
function network_scan() {
    echo "Performing a network scan with Nmap..."
    sudo apt install -y nmap
    read -p "Enter the network range to scan (e.g., 192.168.1.0/24): " network_range
    sudo nmap -sP $network_range
    echo "Network scan completed."
}

# Function to perform a vulnerability scan with Lynis
function vulnerability_scan() {
    echo "Performing a vulnerability scan with Lynis..."
    sudo apt install -y lynis
    sudo lynis audit system
    echo "Vulnerability scan completed."
}

# Function to display the main menu
function main_menu() {
    echo "Main Menu:"
    echo "1. Detailed Security Scan"
    echo "2. Quick Security Scan"
    echo "3. Offline Security Scan"
    echo "4. Malware Scan (Maldet)"
    echo "5. Filesystem Integrity Check (AIDE)"
    echo "6. Network Scan (Nmap)"
    echo "7. Vulnerability Scan (Lynis)"
    echo "8. Exit"
    echo ""
    read -p "Choose an option [1-8]: " choice
    case $choice in
        1) detailed_scan ;;
        2) quick_scan ;;
        3) offline_scan ;;
        4) malware_scan ;;
        5) integrity_check ;;
        6) network_scan ;;
        7) vulnerability_scan ;;
        8) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Start the script by displaying the main menu
main_menu