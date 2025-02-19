#!/bin/bash

# Note: This script should be run with sudo privileges on Debian-based systems.
# 


cat << "EOF"

 ______  ______ _____  _    _       __  __    _    ____  _  _______ _____ 
|  _ \ \/ /  _ \_   _|/ \  | |     |  \/  |  / \  |  _ \| |/ / ____|_   _|
| |_) \  /| |_) || | / _ \ | |     | |\/| | / _ \ | |_) | ' /|  _|   | |  
|  __//  \|  _ < | |/ ___ \| |___  | |  | |/ ___ \|  _ <| . \| |___  | |  
|_|  /_/\_\_| \_\|_/_/   \_\_____| |_|  |_/_/   \_\_| \_\_|\_\_____| |_|  
                                                             
                   Pxrtal OS Software Market
                                                                                                   
EOF

echo "------------------"
echo "Have a nice day!"
echo "------------------"
echo "1) Cyber Security Packages"
echo "2) Music Production Packages"
echo "3) Gaming Packages"
echo "4) Privacy Packages"
echo "5) Graphic Design Packages"
echo "6) Video Editing Packages"
echo "7) System Packages - Other Packages"
echo "8) Software Developer Packages"
echo ""
read -p "Please enter a choice: " choice

case $choice in
  1)
    echo "Cyber Security Packages options:"
    echo "1) Add Repository and Key"
    echo "2) Information Gathering Tools - OSINT & Information Gathering"
    echo "3) Vulnerability Assessment Tools - Vulnerability Assessments"
    echo "4) Web Application Attack Tools - Web Attacks"
    echo "5) Database Attack Tools - Database Attacks"
    echo "6) Password Cracking Tools - Password Cracking"
    echo "7) Wireless Protocol Tools - Wireless Tools"
    echo "8) Reverse Engineering Tools - Reverse Engineering"
    echo "9) Exploitation Tools - Exploitation"
    echo "10) Social Engineering Tools - Social Engineering"
    echo "11) Sniffing & Spoofing Tools - Sniffing & Spoofing"
    echo "12) Post Exploitation Tools - Post Exploitation"
    echo "13) Forensic Tools - Forensics"
    echo "14) Reporting Tools - Reporting"
    echo "15) Install ALL Security Tools"
    echo ""
    read -p "Please enter a choice: " kali_choice
    case $kali_choice in
      1)
        echo "Adding repository and key..."
        sudo apt update
        sudo apt install -y wget gnupg
        wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -
        echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list.d/kali.list
        sudo apt update
        echo "Repository and key added successfully!"
        ;;
      2)
        echo "Installing Information Gathering Tools..."
        sudo apt update
        sudo apt install -y kali-tools-information-gathering
        ;;
      3)
        echo "Installing Vulnerability Assessment Tools..."
        sudo apt update
        sudo apt install -y kali-tools-vulnerability
        ;;
      4)
        echo "Installing Web Application Attack Tools..."
        sudo apt update
        sudo apt install -y kali-tools-web
        ;;
      5)
        echo "Installing Database Attack Tools..."
        sudo apt update
        sudo apt install -y kali-tools-database
        ;;
      6)
        echo "Installing Password Cracking Tools..."
        sudo apt update
        sudo apt install -y kali-tools-passwords
        ;;
      7)
        echo "Installing Wireless Protocol Tools..."
        sudo apt update
        sudo apt install -y kali-tools-wireless
        ;;
      8)
        echo "Installing Reverse Engineering Tools..."
        sudo apt update
        sudo apt install -y kali-tools-reverse-engineering
        ;;
      9)
        echo "Installing Exploitation Tools..."
        sudo apt update
        sudo apt install -y kali-tools-exploitation
        ;;
      10)
        echo "Installing Social Engineering Tools..."
        sudo apt update
        sudo apt install -y kali-tools-social-engineering
        ;;
      11)
        echo "Installing Sniffing & Spoofing Tools..."
        sudo apt update
        sudo apt install -y kali-tools-sniffing-spoofing
        ;;
      12)
        echo "Installing Post Exploitation Tools..."
        sudo apt update
        sudo apt install -y kali-tools-post-exploitation
        ;;
      13)
        echo "Installing Forensic Tools..."
        sudo apt update
        sudo apt install -y kali-tools-forensics
        ;;
      14)
        echo "Installing Reporting Tools..."
        sudo apt update
        sudo apt install -y kali-tools-reporting
        ;;
      15)
        echo "Installing ALL Security Tools..."
        sudo apt update
        sudo apt install -y kali-tools-information-gathering \
                            kali-tools-vulnerability \
                            kali-tools-web \
                            kali-tools-database \
                            kali-tools-passwords \
                            kali-tools-wireless \
                            kali-tools-reverse-engineering \
                            kali-tools-exploitation \
                            kali-tools-social-engineering \
                            kali-tools-sniffing-spoofing \
                            kali-tools-post-exploitation \
                            kali-tools-forensics \
                            kali-tools-reporting
        ;;
      *)
        echo "Invalid option."
        ;;
    esac
    ;;
  2)
    echo "Music Production Packages:"
    echo "1) Audacity - Audio Editing Tool"
    echo "2) LMMS - Digital Audio Workstation"
    echo "3) Ardour - Professional DAW"
    echo "4) Hydrogen - Drum Machine"
    echo "5) Qtractor - Multi-Track Editor"
    echo "6) Download ALL Music Production Tools"
    echo ""
    read -p "Please enter a choice: " music_choice
    case $music_choice in
      1)
        echo "Installing Audacity..."
        sudo apt update
        sudo apt install -y audacity
        ;;
      2)
        echo "Installing LMMS..."
        sudo apt update
        sudo apt install -y lmms
        ;;
      3)
        echo "Installing Ardour..."
        sudo apt update
        sudo apt install -y ardour
        ;;
      4)
        echo "Installing Hydrogen..."
        sudo apt update
        sudo apt install -y hydrogen
        ;;
      5)
        echo "Installing Qtractor..."
        sudo apt update
        sudo apt install -y qtractor
        ;;
      6)
        echo "Installing ALL Music Production Tools..."
        sudo apt update
        sudo apt install -y audacity lmms ardour hydrogen qtractor
        ;;
      *)
        echo "Invalid option."
        ;;
    esac
    ;;
  3)
    echo "Gaming Packages:"
    echo "1) Steam - Popular Gaming Platform"
    echo "2) Lutris - Gaming Platform for Linux"
    echo "3) Vulkan - High-Performance Graphics API"
    echo "4) PlayOnLinux - Run Windows Games on Linux"
    echo "5) Wine - Run Windows Applications on Linux"
    echo "6) GameMode - Performance Optimizer for Games"
    echo "7) Discord - Popular Chat Application"
    echo "8) Heroic Game Launcher - Epic Games and GOG Launcher"
    echo "9) Download ALL Gaming Packages"
    echo ""
    read -p "Please enter a choice: " gaming_choice
    case $gaming_choice in
      1)
        echo "Installing Steam..."
        sudo dpkg --add-architecture i386
        sudo apt update
        sudo apt install -y steam-installer
        ;;
      2)
        echo "Installing Lutris..."
        echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
        wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null
        sudo apt update
        sudo apt install -y lutris
        ;;
      3)
        echo "Installing Vulkan..."
        sudo apt update
        sudo apt install -y vulkan-utils
        ;;
      4)
        echo "Installing PlayOnLinux..."
        sudo apt update
        sudo apt install -y playonlinux
        ;;
      5)
        echo "Installing Wine..."
        sudo apt update
        sudo apt install -y wine64 wine32
        ;;
      6)
        echo "Installing GameMode..."
        sudo apt update
        sudo apt install -y gamemode
        ;;
      7)
        echo "Installing Discord..."
        sudo apt update
        sudo apt install -y curl
        curl -sSL https://discord.com/api/download?platform=linux&format=deb -o discord.deb
        sudo dpkg -i discord.deb
        sudo apt --fix-broken install -y
        rm discord.deb
        ;;
      8)
        echo "Installing Heroic Game Launcher..."
        sudo apt update
        sudo apt install -y libgdk-pixbuf2.0-0 libgconf-2-4 libnss3 libatk1.0-0 libgtk-3-0 libasound2
        curl -sSL https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.5.0/heroic_amd64.deb -o heroic.deb
        sudo dpkg -i heroic.deb
        sudo apt --fix-broken install -y
        rm heroic.deb
        ;;
      9)
        echo "Installing ALL Gaming Packages..."
        sudo dpkg --add-architecture i386
        sudo apt update
        sudo apt install -y steam-installer
        echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
        wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null
        sudo apt update
        sudo apt install -y lutris vulkan-utils playonlinux wine64 wine32 gamemode
        ;;
      *)
        echo "Invalid option."
        ;;
    esac
    ;;
  4)
    echo "Privacy Packages:"
    echo "1) Tor Browser - Anonymous Browser"
    echo "2) Proxychains - Connect via Proxy"
    echo "3) VeraCrypt - Data Encryption"
    echo "4) BleachBit - System Cleaner"
    echo "5) ClamAV - Antivirus"
    echo "6) Fail2Ban - Brute-force Protection"
    echo "7) Download ALL Privacy & Security Tools"
    echo ""
    read -p "Please enter a choice: " privacy_security_choice
    case $privacy_security_choice in
      1)
        echo "Installing Tor Browser..."
        sudo apt update
        sudo apt install -y torbrowser-launcher
        ;;
      2)
        echo "Installing Proxychains..."
        sudo apt update
        sudo apt install -y proxychains
        ;;
      3)
        echo "Installing VeraCrypt..."
        sudo apt update
        sudo apt install -y veracrypt
        ;;
      4)
        echo "Installing BleachBit..."
        sudo apt update
        sudo apt install -y bleachbit
        ;;
      5)
        echo "Installing ClamAV..."
        sudo apt update
        sudo apt install -y clamav
        ;;
      6)
        echo "Installing Fail2Ban..."
        sudo apt update
        sudo apt install -y fail2ban
        ;;
      7)
        echo "Installing ALL Privacy & Security Tools..."
        sudo apt update
        sudo apt install -y torbrowser-launcher proxychains veracrypt bleachbit clamav fail2ban
        ;;
      *)
        echo "Invalid option. Please enter a valid option."
        ;;
    esac
    ;;
  5)
    echo "Graphic Design Packages:"
    echo "1) GIMP - Raster Graphics Editor"
    echo "2) Inkscape - Vector Graphics Editor"
    echo "3) Blender - 3D Modeling and Animation"
    echo "4) Krita - Digital Painting"
    echo "5) Darktable - Photo Editing"
    echo "6) Shotwell - Photo Management"
    echo "7) Download ALL Graphic Design Tools"
    echo ""
    read -p "Please enter a choice: " graphic_design_choice
    case $graphic_design_choice in
      1)
        echo "Installing GIMP..."
        sudo apt update
        sudo apt install -y gimp
        ;;
      2)
        echo "Installing Inkscape..."
        sudo apt update
        sudo apt install -y inkscape
        ;;
      3)
        echo "Installing Blender..."
        sudo apt update
        sudo apt install -y blender
        ;;
      4)
        echo "Installing Krita..."
        sudo apt update
        sudo apt install -y krita
        ;;
      5)
        echo "Installing Darktable..."
        sudo apt update
        sudo apt install -y darktable
        ;;
      6)
        echo "Installing Shotwell..."
        sudo apt update
        sudo apt install -y shotwell
        ;;
      7)
        echo "Installing ALL Graphic Design Tools..."
        sudo apt update
        sudo apt install -y gimp inkscape blender krita darktable shotwell
        ;;
      *)
        echo "Invalid option. Please enter a valid option."
        ;;
    esac
    ;;
  6)
    echo "Video Editing Packages:"
    echo "1) Kdenlive - Video Editing"
    echo "2) Shotcut - Video Editing"
    echo "3) OpenShot - Video Editing"
    echo "4) Blender - Video Editing (3D Modeling and Animation)"
    echo "5) Pitivi - Simple Video Editing"
    echo "6) DaVinci Resolve - Professional Video Editing"
    echo "7) Download ALL Video Editing Tools"
    echo ""
    read -p "Please enter a choice: " video_editing_choice
    case $video_editing_choice in
      1)
        echo "Installing Kdenlive..."
        sudo apt update
        sudo apt install -y kdenlive
        ;;
      2)
        echo "Installing Shotcut..."
        sudo apt update
        sudo apt install -y shotcut
        ;;
      3)
        echo "Installing OpenShot..."
        sudo apt update
        sudo apt install -y openshot
        ;;
      4)
        echo "Installing Blender..."
        sudo apt update
        sudo apt install -y blender
        ;;
      5)
        echo "Installing Pitivi..."
        sudo apt update
        sudo apt install -y pitivi
        ;;
      6)
        echo "Installing DaVinci Resolve..."
        sudo apt update
        sudo apt install -y davinci-resolve
        ;;
      7)
        echo "Installing ALL Video Editing Tools..."
        sudo apt update
        sudo apt install -y kdenlive shotcut openshot blender pitivi davinci-resolve
        ;;
      *)
        echo "Invalid option. Please enter a valid option."
        ;;
    esac
    ;;
  7)
    echo "System Packages - Other Packages:"
    echo "1) GParted - Disk Management Tool"
    echo "2) Google Chrome - Web Browser"
    echo "3) Opera - Web Browser"
    echo "4) LibreWolf - Privacy-Focused Browser"
    echo "5) VLC - Media Player"
    echo "6) MPV - Lightweight Media Player"
    echo "7) Elisa - Music Player"
    echo "8) Flatpak - Package Management System"
    echo "9) Snap - Package Management System"
    echo "10) LibreOffice - Office Suite"
    echo "11) OBS Studio - Streaming and Recording"
    echo "12) Torrent Client"
    echo "13) Okular - Document Viewer"
    echo "14) Vim - Text Editor"
    echo "15) Bottles - Wine Prefix Manager"
    echo "16) Fish - Friendly Interactive Shell"
    echo "17) Skype - Communication Tool"
    echo "18) Telegram - Messaging App"
    echo "19) Thunderbird - Email Client"
    echo "20) Htop -  System Status Monitoring"
    echo ""
    read -p "Please enter a choice: " other_choice
    case $other_choice in
      1)
        echo "Installing GParted..."
        sudo apt update
        sudo apt install -y gparted
        ;;
      2)
        echo "Installing Google Chrome..."
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
        sudo apt update
        sudo apt install -y google-chrome-stable
        ;;
      3)
        echo "Installing Opera..."
        wget -q -O - https://deb.opera.com/archive.key | sudo apt-key add -
        sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
        sudo apt update
        sudo apt install -y opera-stable
        ;;
      4)
        echo "Installing LibreWolf..."
        sudo apt update
        sudo apt install -y wget gnupg
        wget -qO- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
        sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $(lsb_release -sc)
Components: main
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
        sudo apt update
        sudo apt install -y librewolf
        ;;
      5)
        echo "Installing VLC..."
        sudo apt update
        sudo apt install -y vlc
        ;;
      6)
        echo "Installing MPV..."
        sudo apt update
        sudo apt install -y mpv
        ;;
      7)
        echo " Installing Elisa..."
        sudo apt update
        sudo apt install -y elisa
        ;;
      8)
        echo "Installing Flatpak..."
        sudo apt update
        sudo apt install -y flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        ;;
      9)
        echo "Installing Snap..."
        sudo apt update
        sudo apt install -y snapd
        sudo systemctl enable --now snapd.socket
        ;;
      10)
        echo "Installing LibreOffice..."
        sudo apt update
        sudo apt install -y libreoffice
        ;;
      11)
        echo "Installing OBS Studio..."
        sudo apt update
        sudo apt install -y obs-studio
        ;;
      12)
        echo "Installing Torrent Client..."
        sudo apt update
        sudo apt install -y transmission
        ;;
      13)
        echo "Installing Okular..."
        sudo apt update
        sudo apt install -y okular
        ;;
      14)
        echo "Installing Vim..."
        sudo apt update
        sudo apt install -y vim
        ;;
      15)
        echo "Installing Bottles..."
        sudo apt update
        sudo apt install -y bottles
        ;;
      16)
        echo "Installing Fish..."
        sudo apt update
        sudo apt install -y fish
        ;;
      17)
        echo "Installing Skype..."
        sudo apt update
        sudo apt install -y skypeforlinux
        ;;
      18)
        echo "Installing Telegram..."
        sudo apt update
        sudo apt install -y telegram-desktop
        ;;
      19)
        echo "Installing Thunderbird..."
        sudo apt update
        sudo apt install -y thunderbird
        ;;
      20)
        echo "Installing Htop "
        sudo apt update
        sudo apt install -y htop
        ;;
  *)
    echo "Invalid option."
    ;;
esac    
;;
  8)
    echo "Software Developer Packages:"
    echo "1) Python3"
    echo "2) Ruby"
    echo "3) Visual Studio Code"
    echo "4) Eclipse"
    echo "5) IntelliJ IDEA"
    echo "6) PyCharm"
    echo "7) Sublime Text"
    echo "8) Java"
    echo "9) C/C++"
    echo "10) Node.js (JavaScript)"
    echo "11) Go"
    echo "12) Apache HTTP Server"
    echo "13) Nginx"
    echo "14) LiteSpeed"
    echo "15) Caddy"
    echo "16) MySQL"
    echo "17) PostgreSQL"
    echo "18) SQLite"
    echo "19) MariaDB"
    echo "20) MongoDB"
    echo "21) pip"
    echo ""
    read -p "Please enter a choice: " dev_choice
    case $dev_choice in
      1)
        echo "Installing Python3..."
        sudo apt update
        sudo apt install -y python3
        ;;
      2)
        echo "Installing Ruby..."
        sudo apt update
        sudo apt install -y ruby
        ;;
      3)
        echo "Installing Visual Studio Code..."
        sudo apt update
        sudo apt install -y software-properties-common apt-transport-https wget
        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
        sudo apt update
        sudo apt install -y code
        ;;
      4)
        echo "Installing Eclipse..."
        sudo apt update
        sudo apt install -y eclipse
        ;;
      5)
        echo "Installing IntelliJ IDEA..."
        sudo snap install intellij-idea-community --classic
        ;;
      6)
        echo "Installing PyCharm..."
        sudo snap install pycharm-community --classic
        ;;
      7)
        echo "Installing Sublime Text..."
        sudo apt update
        sudo apt install -y apt-transport-https
        curl -s https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt update
        sudo apt install -y sublime-text
        ;;
      8)
        echo "Installing Java..."
        sudo apt update
        sudo apt install -y default-jdk
        ;;
      9)
        echo "Installing C/C++..."
        sudo apt update
        sudo apt install -y build-essential
        ;;
      10)
        echo "Installing Node.js..."
        sudo apt update
        sudo apt install -y nodejs npm
        ;;
      11)
        echo "Installing Go..."
        sudo apt update
        sudo apt install -y golang
        ;;
      12)
        echo "Installing Apache HTTP Server..."
        sudo apt update
        sudo apt install -y apache2
        ;;
      13)
        echo "Installing Nginx..."
        sudo apt update
        sudo apt install -y nginx
        ;;
      14)
        echo "Installing LiteSpeed..."
        sudo apt update
        sudo apt install -y openlitespeed
        ;;
      15)
        echo "Installing Caddy..."
        sudo apt update
        sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
        curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo apt-key add -
        curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee -a /etc/apt/sources.list.d/caddy-stable.list
        sudo apt update
        sudo apt install -y caddy
        ;;
      16)
        echo "Installing MySQL..."
        sudo apt update
        sudo apt install -y mysql-server
        ;;
      17)
        echo "Installing PostgreSQL..."
        sudo apt update
        sudo apt install -y postgresql postgresql-contrib
        ;;
      18)
        echo "Installing SQLite..."
        sudo apt update
        sudo apt install -y sqlite3
        ;;
      19)
        echo "Installing MariaDB..."
        sudo apt update
        sudo apt install -y mariadb-server
        ;;
      20)
        echo "Installing MongoDB..."
        sudo apt update
        sudo apt install -y mongodb
        ;;
      21)
        echo "Installing pip..."
        sudo apt update
        sudo apt install -y pip
        ;;
      *)
        echo "Invalid option."
        ;;
    esac
    ;;
  *)
    echo "Invalid option."
    ;;
esac