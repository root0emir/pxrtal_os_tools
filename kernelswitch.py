import os
import subprocess
import re
import sys

def run_command(command):
    """Run a shell command and return the output."""
    try:
        result = subprocess.run(command, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result.stdout.decode('utf-8').strip()
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running command: {' '.join(command)}")
        print(e.stderr.decode('utf-8').strip())
        sys.exit(1)

def get_current_kernel():
    """Get the current running kernel version."""
    return run_command(["uname", "-r"])

def list_installed_kernels():
    """List all installed kernels."""
    kernels = run_command(["dpkg", "--list", "linux-image*"])
    return kernels

def kernel_choice_menu():
    """Display the kernel choice menu and return the user's choice."""
    print("Select the kernel you want to install:")
    print("1. Standard Kernel (linux-image-amd64)")
    print("2. Zen Kernel (linux-image-zen)")
    print("3. Hardened Kernel (linux-image-hardened)")
    print("4. Real-Time Kernel (linux-image-rt)")
    print("5. Low Latency Kernel (linux-image-lowlatency)")
    choice = input("Enter your choice (1, 2, 3, 4, or 5): ").strip()
    return choice

def backup_choice_menu():
    """Ask the user if they want to backup the current kernel."""
    choice = input("Do you want to backup the current kernel? (yes/no): ").strip().lower()
    return choice == 'yes'

def get_backup_directory():
    """Ask the user for the backup directory."""
    backup_dir = input("Enter the directory to save the kernel backup (default: /root/kernel_backup): ").strip()
    if not backup_dir:
        backup_dir = "/root/kernel_backup"
    return backup_dir

def backup_current_kernel(current_kernel, backup_dir):
    """Backup the current running kernel."""
    if not os.path.exists(backup_dir):
        os.makedirs(backup_dir)
    kernel_version = re.sub(r'-\d+-\w+', '', current_kernel)
    kernel_files = [f"/boot/vmlinuz-{kernel_version}", f"/boot/initrd.img-{kernel_version}"]
    for file in kernel_files:
        if os.path.exists(file):
            print(f"Backing up {file} to {backup_dir}...")
            run_command(["sudo", "cp", file, backup_dir])
    print("Kernel backup completed.")

def install_kernel(kernel_name):
    """Install the specified kernel and update GRUB configuration."""
    try:
        # Update the package list
        print("Updating package list...")
        run_command(["sudo", "apt", "update"])

        # Install the chosen kernel and headers
        print(f"Installing {kernel_name} and headers...")
        run_command(["sudo", "apt", "install", "-y", kernel_name, f"{kernel_name}-headers"])

        # Remove the old kernel if exists
        old_kernels = [
            "linux-image-amd64", "linux-headers-amd64",
            "linux-image-zen", "linux-headers-zen",
            "linux-image-hardened", "linux-headers-hardened",
            "linux-image-rt", "linux-headers-rt",
            "linux-image-lowlatency", "linux-headers-lowlatency"
        ]
        old_kernels_to_remove = [k for k in old_kernels if k not in [kernel_name, f"{kernel_name}-headers"]]
        for old_kernel in old_kernels_to_remove:
            try:
                print(f"Removing old kernel: {old_kernel}...")
                run_command(["sudo", "apt", "remove", "-y", old_kernel])
            except subprocess.CalledProcessError:
                pass  # Ignore errors if the old kernel is not installed

        # Update GRUB configuration
        print("Updating GRUB configuration...")
        run_command(["sudo", "update-grub"])

        print(f"{kernel_name} kernel installed and configured successfully. Please reboot your system.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred: {e}")
        print("Kernel installation failed.")
        sys.exit(1)

def main():
    current_kernel = get_current_kernel()
    print(f"Current running kernel: {current_kernel}")

    print("Installed kernels:")
    print(list_installed_kernels())

    choice = kernel_choice_menu()
    if choice == '1':
        install_kernel("linux-image-amd64")
    elif choice == '2':
        install_kernel("linux-image-zen")
    elif choice == '3':
        install_kernel("linux-image-hardened")
    elif choice == '4':
        install_kernel("linux-image-rt")
    elif choice == '5':
        install_kernel("linux-image-lowlatency")
    else:
        print("Invalid choice. Please run the script again and select a valid option.")
        sys.exit(1)

    if backup_choice_menu():
        backup_dir = get_backup_directory()
        backup_current_kernel(current_kernel, backup_dir)

if __name__ == "__main__":
    main()