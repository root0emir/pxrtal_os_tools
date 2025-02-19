#!/bin/bash

echo "---------------------------------------"
echo "    Welcome to Pxrtal OS Customizer    "
echo "---------------------------------------"
echo ""
echo "This script allows you to customize various aspects of your Linux system."
echo ""

# Function to display the main menu
function main_menu() {
    echo "Main Menu:"
    echo "1. Change Hostname"
    echo "2. Set Timezone"
    echo "3. Configure Network"
    echo "4. Customize Shell Prompt"
    echo "5. Create Aliases"
    echo "6. Set Up Cron Jobs"
    echo "7. Configure Firewall"
    echo "8. Optimize System Performance"
    echo "9. Customize System Appearance"
    echo "10. Exit"
    echo ""
    read -p "Choose an option [1-10]: " choice
    case $choice in
        1) change_hostname ;;
        2) set_timezone ;;
        3) configure_network ;;
        4) customize_shell_prompt ;;
        5) create_aliases ;;
        6) set_up_cron_jobs ;;
        7) configure_firewall ;;
        8) optimize_system_performance ;;
        9) customize_system_appearance ;;
        10) exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Function to change the hostname
function change_hostname() {
    read -p "Enter new hostname: " new_hostname
    sudo hostnamectl set-hostname $new_hostname
    echo "Hostname changed to $new_hostname"
    main_menu
}

# Function to set the timezone
function set_timezone() {
    read -p "Enter timezone (e.g., Europe/Istanbul): " timezone
    sudo timedatectl set-timezone $timezone
    echo "Timezone set to $timezone"
    main_menu
}

# Function to configure network
function configure_network() {
    echo "Network Configuration:"
    echo "1. Set Static IP"
    echo "2. Set DHCP"
    echo "3. Configure DNS"
    echo "4. Back to Main Menu"
    read -p "Choose an option [1-4]: " choice
    case $choice in
        1) set_static_ip ;;
        2) set_dhcp ;;
        3) configure_dns ;;
        4) main_menu ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

function set_static_ip() {
    read -p "Enter network interface (e.g., eth0): " iface
    read -p "Enter static IP: " static_ip
    read -p "Enter netmask: " netmask
    read -p "Enter gateway: " gateway
    sudo nmcli con mod $iface ipv4.addresses $static_ip/$netmask
    sudo nmcli con mod $iface ipv4.gateway $gateway
    sudo nmcli con mod $iface ipv4.method manual
    sudo nmcli con up $iface
    echo "Static IP set to $static_ip"
    configure_network
}

function set_dhcp() {
    read -p "Enter network interface (e.g., eth0): " iface
    sudo nmcli con mod $iface ipv4.method auto
    sudo nmcli con up $iface
    echo "DHCP configuration applied."
    configure_network
}

function configure_dns() {
    read -p "Enter DNS servers (comma separated): " dns_servers
    sudo nmcli con mod $iface ipv4.dns $dns_servers
    sudo nmcli con up $iface
    echo "DNS servers set to $dns_servers"
    configure_network
}

# Function to customize shell prompt
function customize_shell_prompt() {
    read -p "Enter new shell prompt (e.g., \u@\h:\w\$): " shell_prompt
    echo "PS1='$shell_prompt'" >> ~/.bashrc
    source ~/.bashrc
    echo "Shell prompt changed to $shell_prompt"
    main_menu
}

# Function to create aliases
function create_aliases() {
    read -p "Enter alias (e.g., ll='ls -la'): " alias
    echo "alias $alias" >> ~/.bashrc
    source ~/.bashrc
    echo "Alias $alias added."
    main_menu
}

# Function to set up cron jobs
function set_up_cron_jobs() {
    read -p "Enter cron job (e.g., 0 5 * * * /path/to/script.sh): " cron_job
    (crontab -l; echo "$cron_job") | crontab -
    echo "Cron job added: $cron_job"
    main_menu
}

# Function to configure firewall
function configure_firewall() {
    echo "Firewall Configuration:"
    echo "1. Allow Port"
    echo "2. Deny Port"
    echo "3. Enable Firewall"
    echo "4. Disable Firewall"
    echo "5. Back to Main Menu"
    read -p "Choose an option [1-5]: " choice
    case $choice in
        1) allow_port ;;
        2) deny_port ;;
        3) enable_firewall ;;
        4) disable_firewall ;;
        5) main_menu ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

function allow_port() {
    read -p "Enter port number to allow: " port
    sudo ufw allow $port
    echo "Port $port allowed."
    configure_firewall
}

function deny_port() {
    read -p "Enter port number to deny: " port
    sudo ufw deny $port
    echo "Port $port denied."
    configure_firewall
}

function enable_firewall() {
    sudo ufw enable
    echo "Firewall enabled."
    configure_firewall
}

function disable_firewall() {
    sudo ufw disable
    echo "Firewall disabled."
    configure_firewall
}

# Function to optimize system performance
function optimize_system_performance() {
    echo "Optimizing system performance..."
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt clean
    echo "System performance optimized."
    main_menu
}

# Function to customize system appearance
function customize_system_appearance() {
    echo "System Appearance Customization:"
    echo "1. Change Wallpaper"
    echo "2. Change Terminal Colors"
    echo "3. Change Desktop Environment Theme"
    echo "4. Change Font Settings"
    echo "5. Set Up GTK Theme"
    echo "6. Set Up Icon Theme"
    echo "7. Back to Main Menu"
    read -p "Choose an option [1-7]: " choice
    case $choice in
        1) change_wallpaper ;;
        2) change_terminal_colors ;;
        3) change_desktop_theme ;;
        4) change_font_settings ;;
        5) setup_gtk_theme ;;
        6) setup_icon_theme ;;
        7) main_menu ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

function change_wallpaper() {
    read -p "Enter the path to the wallpaper image: " wallpaper_path
    gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"
    echo "Wallpaper changed to $wallpaper_path"
    customize_system_appearance
}

function change_terminal_colors() {
    read -p "Enter the profile name (default: 'Default'): " profile_name
    profile_name=${profile_name:-Default}
    read -p "Enter the background color (e.g., '#000000' for black): " bg_color
    read -p "Enter the foreground color (e.g., '#FFFFFF' for white): " fg_color
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_name/" background-color "$bg_color"
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile_name/" foreground-color "$fg_color"
    echo "Terminal colors changed for profile $profile_name"
    customize_system_appearance
}

function change_desktop_theme() {
    read -p "Enter the name of the GTK theme: " gtk_theme
    read -p "Enter the name of the icon theme: " icon_theme
    gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme"
    gsettings set org.gnome.desktop.interface icon-theme "$icon_theme"
    echo "Desktop theme changed to GTK theme $gtk_theme and icon theme $icon_theme"
    customize_system_appearance
}

function change_font_settings() {
    read -p "Enter the font name (e.g., 'Ubuntu 12'): " font_name
    gsettings set org.gnome.desktop.interface font-name "$font_name"
    echo "Font settings changed to $font_name"
    customize_system_appearance
}

function setup_gtk_theme() {
    read -p "Enter the name of the GTK theme: " gtk_theme
    gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme"
    echo "GTK theme set to $gtk_theme"
    customize_system_appearance
}

function setup_icon_theme() {
    read -p "Enter the name of the icon theme: " icon_theme
    gsettings set org.gnome.desktop.interface icon-theme "$icon_theme"
    echo "Icon theme set to $icon_theme"
    customize_system_appearance
}

# Start the script by displaying the main menu
main_menu