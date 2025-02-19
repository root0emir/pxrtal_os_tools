#!/bin/bash

echo "---------------------------------------"
echo "        Welcome to Learn Linux         "
echo "---------------------------------------"
echo ""
echo "This script will guide you through the basic Linux commands and their usage."
echo ""

# Function to display the usage of a command
function show_command_usage() {
    local command=$1
    local description=$2
    local example=$3

    echo "Command: $command"
    echo "Description: $description"
    echo "Example: $example"
    echo ""
}

# Array of commands with their descriptions and examples
commands=(
    "ls|List directory contents|ls -l"
    "cd|Change directory|cd /home"
    "pwd|Print working directory|pwd"
    "mkdir|Create a new directory|mkdir myfolder"
    "rm|Remove files or directories|rm myfile.txt"
    "cp|Copy files or directories|cp source.txt destination.txt"
    "mv|Move (rename) files or directories|mv oldname.txt newname.txt"
    "touch|Create an empty file or update the timestamp of an existing file|touch newfile.txt"
    "cat|Concatenate and display file content|cat myfile.txt"
    "echo|Display a line of text|echo 'Hello, World!'"
    "man|Display the manual page for a command|man ls"
    "grep|Search for patterns in files|grep 'search_term' myfile.txt"
    "find|Search for files in a directory hierarchy|find /home -name 'myfile.txt'"
    "chmod|Change file modes or Access Control Lists|chmod 755 myfile.txt"
    "chown|Change file owner and group|chown user:group myfile.txt"
    "df|Report file system disk space usage|df -h"
    "du|Estimate file space usage|du -sh myfolder"
    "ps|Report a snapshot of current processes|ps aux"
    "top|Display Linux tasks|top"
    "kill|Send a signal to a process|kill 1234"
    "tar|Archive files|tar -czvf archive.tar.gz myfolder"
    "wget|Non-interactive network downloader|wget http://example.com/file.zip"
    "curl|Transfer data from or to a server|curl http://example.com"
    "ssh|OpenSSH SSH client (remote login program)|ssh user@hostname"
    "nano|Simple, easy-to-use text editor|nano myfile.txt"
    "vi|Vi IMproved, a programmer's text editor|vi myfile.txt"
)

# Display the commands and their usage
for cmd in "${commands[@]}"; do
    IFS='|' read -r command description example <<< "$cmd"
    show_command_usage "$command" "$description" "$example"
done

