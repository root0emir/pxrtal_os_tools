#!/bin/bash

cat << "EOF"
---------------------------------------
        Welcome to DimensionalRift    
---------------------------------------
 _____   _                        _                   _ ______  _  ___      
(____ \ (_)                      (_)                 | (_____ \(_)/ __)_    
 _   \ \ _ ____   ____ ____   ___ _  ___  ____   ____| |_____) )_| |__| |_  
| |   | | |    \ / _  )  _ \ /___) |/ _ \|  _ \ / _  | (_____ (| |  __)  _) 
| |__/ /| | | | ( (/ /| | | |___ | | |_| | | | ( ( | | |     | | | |  | |__ 
|_____/ |_|_|_|_|\____)_| |_(___/|_|\___/|_| |_|\_||_|_|     |_|_|_|   \___)
                                                                            
---------------------------------------
DimensionalRift is a tool that routes all internet traffic through the Tor network, providing various anonymity and security features.
---------------------------------------
EOF

# Check if Tor is installed
if ! command -v tor &> /dev/null
then
    echo "Tor is not installed. Installing Tor..."
    sudo apt update
    sudo apt install -y tor
fi

# Function to start TOR service
function start_tor_service() {
    echo "Starting Tor service..."
    sudo systemctl start tor
    sudo systemctl enable tor
    echo "Tor service started."
}

# Function to stop TOR service
function stop_tor_service() {
    echo "Stopping Tor service..."
    sudo systemctl stop tor
    sudo systemctl disable tor
    echo "Tor service stopped."
}

# Function to start routing all traffic through Tor
function start_tor_traffic_routing() {
    start_tor_service
    echo "Configuring system to route all traffic through Tor..."
    # Backup original iptables rules
    sudo iptables-save > ~/iptables.backup
    
    # Flush iptables rules
    sudo iptables -F
    
    # Redirect all traffic through Tor
    sudo iptables -t nat -A OUTPUT -m owner ! --uid-owner debian-tor -p udp --dport 53 -j REDIRECT --to-ports 5353
    sudo iptables -t nat -A OUTPUT -m owner ! --uid-owner debian-tor -p tcp --syn -j REDIRECT --to-ports 9040
    sudo iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    sudo iptables -A OUTPUT -m owner --uid-owner debian-tor -j ACCEPT
    sudo iptables -A OUTPUT -j DROP

    echo "All traffic is now routed through Tor."
}

# Function to stop routing all traffic through Tor
function stop_tor_traffic_routing() {
    stop_tor_service
    echo "Reverting system to original iptables rules..."
    # Restore original iptables rules
    sudo iptables-restore < ~/iptables.backup
    echo "System iptables rules reverted."
}

# Function to change identity
function change_identity() {
    echo "Changing Tor identity..."
    if sudo systemctl reload tor; then
        echo "Tor identity changed successfully."
    else
        echo "Failed to change Tor identity."
    fi
}

# Function to check connection
function check_connection() {
    echo "Checking Tor connection..."
    curl --socks5 localhost:9050 https://check.torproject.org/api/ip
}

# Function to check circuits
function check_circuits() {
    echo "Checking Tor circuits..."
    sudo nyx
}

# Function to display the main menu
function main_menu() {
    echo "Main Menu:"
    echo "1. Start Tor Traffic Routing"
    echo "2. Stop Tor Traffic Routing"
    echo "3. Change Identity"
    echo "4. Check Connection"
    echo "5. Check Circuits"
    echo "6. Exit"
    echo ""
    read -p "Choose an option [1-6]: " choice
    case $choice in
        1) start_tor_traffic_routing ;;
        2) stop_tor_traffic_routing ;;
        3) change_identity ;;
        4) check_connection ;;
        5) check_circuits ;;
        6) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Ensure Tor service is running before starting the menu
start_tor_service

# Start the script by displaying the main menu
main_menu