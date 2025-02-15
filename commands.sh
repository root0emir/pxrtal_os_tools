#!/bin/bash

# PXRTAL OS özel komutlar listesi
commands=(
    "pxrtal: System manager tool"
    "pxrtalmarket: Software market for PXRTAL OS"
    "pxrtalupdate: Update tool for PXRTAL OS"
    "about: About PXRTAL OS"
    "help: Help command for PXRTAL OS"
    "donate: Donate link for PXRTAL OS"
    "pxrtalbackup: Backup tool for PXRTAL OS"
)

echo "PXRTAL OS Special Commands:"
echo "--------------------------"


for cmd in "${commands[@]}"; do
    echo "$cmd"
done

echo "--------------------------"
echo "Use the above commands to manage your PXRTAL OS system."