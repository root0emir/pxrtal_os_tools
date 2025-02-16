#!/bin/bash

# PXRTAL OS USB KIT Script
# This script will list connected USB devices, check USB health, perform USB formatting operations,
# mount/unmount USB devices, show USB device information, backup/restore data, and analyze disk usage.

# ASCII Art
cat << "EOF"
  _____  _____ _____ _   _                           
 | _ \ \/ / _ \_   _/_\ | |                          
 |  _/>  <|   / | |/ _ \| |__                        
 |_| /_/\_\_|_\ |_/_/ \_\____|_  _    _  _____ _____ 
 | | | / __| _ )_   _/ _ \ / _ \| |  | |/ /_ _|_   _|
 | |_| \__ \ _ \ | || (_) | (_) | |__| ' < | |  | |  
  \___/|___/___/ |_| \___/ \___/|____|_|\_\___| |_|  
                                                
EOF

# List connected USB devices
list_usb_devices() {
    echo "Connected USB Devices:"
    lsblk -o NAME,SIZE,VENDOR,MODEL,MOUNTPOINT | grep -i "sd"
}

# Check USB health
check_usb_health() {
    read -p "Enter the name of the USB device to check health (e.g., sdb): " usb_device
    if [ -b "/dev/$usb_device" ]; then
        echo "Checking health of USB device /dev/$usb_device..."
        smartctl -H /dev/$usb_device
    else
        echo "Invalid USB device name!"
    fi
}

# Format USB
format_usb() {
    read -p "Enter the name of the USB device to format (e.g., sdb): " usb_device
    if [ -b "/dev/$usb_device" ]; then
        echo "Formatting USB device /dev/$usb_device..."
        read -p "All data will be lost! Do you want to continue? (y/n): " confirm
        if [ "$confirm" == "y" ]; then
            sudo mkfs.vfat -F 32 /dev/$usb_device
            echo "USB device /dev/$usb_device formatted successfully."
        else
            echo "Formatting operation cancelled."
        fi
    else
        echo "Invalid USB device name!"
    fi
}

# Mount USB device
mount_usb() {
    read -p "Enter the name of the USB device to mount (e.g., sdb1): " usb_device
    read -p "Enter the mount point directory (e.g., /mnt/usb): " mount_point
    if [ -b "/dev/$usb_device" ]; then
        sudo mount /dev/$usb_device $mount_point
        echo "USB device /dev/$usb_device mounted at $mount_point."
    else
        echo "Invalid USB device name or mount point!"
    fi
}

# Unmount USB device
unmount_usb() {
    read -p "Enter the name of the USB device to unmount (e.g., sdb1): " usb_device
    if [ -b "/dev/$usb_device" ]; then
        sudo umount /dev/$usb_device
        echo "USB device /dev/$usb_device unmounted."
    else
        echo "Invalid USB device name!"
    fi
}

# Show USB device information
show_usb_info() {
    read -p "Enter the name of the USB device to show information (e.g., sdb): " usb_device
    if [ -b "/dev/$usb_device" ]; then
        sudo lsblk -o NAME,FSTYPE,LABEL,UUID,MOUNTPOINT,SIZE,MODEL /dev/$usb_device
    else
        echo "Invalid USB device name!"
    fi
}

# Backup data from USB
backup_usb_data() {
    read -p "Enter the name of the USB device to backup data (e.g., sdb1): " usb_device
    read -p "Enter the backup destination directory (e.g., /backup): " backup_dir
    if [ -b "/dev/$usb_device" ]; then
        sudo rsync -a /dev/$usb_device $backup_dir
        echo "Data from /dev/$usb_device has been backed up to $backup_dir."
    else
        echo "Invalid USB device name or destination directory!"
    fi
}

# Restore data to USB
restore_usb_data() {
    read -p "Enter the name of the USB device to restore data (e.g., sdb1): " usb_device
    read -p "Enter the backup source directory (e.g., /backup): " backup_dir
    if [ -b "/dev/$usb_device" ]; then
        sudo rsync -a $backup_dir /dev/$usb_device
        echo "Data from $backup_dir has been restored to /dev/$usb_device."
    else
        echo "Invalid USB device name or source directory!"
    fi
}

# Analyze disk usage
analyze_disk_usage() {
    read -p "Enter the name of the USB device to analyze disk usage (e.g., sdb1): " usb_device
    if [ -b "/dev/$usb_device" ]; then
        sudo df -h /dev/$usb_device
    else
        echo "Invalid USB device name!"
    fi
}

# Main menu
while true; do
    echo "Pxrtal OS - USB TOOLKIT"
    echo "1. Show connected USB devices"
    echo "2. Check USB health"
    echo "3. Format USB"
    echo "4. Mount USB device"
    echo "5. Unmount USB device"
    echo "6. Show USB device information"
    echo "7. Backup data from USB"
    echo "8. Restore data to USB"
    echo "9. Analyze disk usage"
    echo "10. Exit"
    read -p "Select an option (1-10): " choice

    case $choice in
        1)
            list_usb_devices
            ;;
        2)
            check_usb_health
            ;;
        3)
            format_usb
            ;;
        4)
            mount_usb
            ;;
        5)
            unmount_usb
            ;;
        6)
            show_usb_info
            ;;
        7)
            backup_usb_data
            ;;
        8)
            restore_usb_data
            ;;
        9)
            analyze_disk_usage
            ;;
        10)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid selection! Please choose between 1-10."
            ;;
    esac
done