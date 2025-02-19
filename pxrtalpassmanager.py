#!/usr/bin/env python3
import os
import json
import getpass
import csv
from cryptography.fernet import Fernet

class TerminalPasswordManager:
    def __init__(self, file_path='passwords.json'):
        self.file_path = file_path
        self.key = self.load_key()
        self.fernet = Fernet(self.key)
        self.passwords = self.load_passwords()

    def load_key(self):
        key_path = 'secret.key'
        if os.path.exists(key_path):
            with open(key_path, 'rb') as key_file:
                return key_file.read()
        else:
            key = Fernet.generate_key()
            with open(key_path, 'wb') as key_file:
                key_file.write(key)
            return key

    def load_passwords(self):
        if os.path.exists(self.file_path):
            with open(self.file_path, 'rb') as file:
                encrypted_data = file.read()
                decrypted_data = self.fernet.decrypt(encrypted_data).decode()
                return json.loads(decrypted_data)
        return {}

    def save_passwords(self):
        encrypted_data = self.fernet.encrypt(json.dumps(self.passwords).encode())
        with open(self.file_path, 'wb') as file:
            file.write(encrypted_data)

    def add_password(self, service, username, password):
        self.passwords[service] = {'username': username, 'password': password}
        self.save_passwords()
        print("Password added.")

    def get_password(self, service):
        if service in self.passwords:
            creds = self.passwords[service]
            print(f"Service: {service}\nUsername: {creds['username']}\nPassword: {creds['password']}")
        else:
            print("Service not found.")

    def update_password(self, service, username, password):
        if service in self.passwords:
            self.passwords[service] = {'username': username, 'password': password}
            self.save_passwords()
            print("Password updated.")
        else:
            print("Service not found.")

    def delete_password(self, service):
        if service in self.passwords:
            del self.passwords[service]
            self.save_passwords()
            print(f"Deleted password for service: {service}")
        else:
            print("Service not found.")

    def search_password(self, keyword):
        results = {service: creds for service, creds in self.passwords.items() if keyword.lower() in service.lower()}
        if not results:
            print("No matching services found.")
        else:
            for service, creds in results.items():
                print(f"Service: {service}\nUsername: {creds['username']}\nPassword: {creds['password']}")

    def import_passwords(self, csv_file):
        try:
            with open(csv_file, 'r') as file:
                reader = csv.DictReader(file)
                for row in reader:
                    service = row['service']
                    username = row['username']
                    password = row['password']
                    self.add_password(service, username, password)
            print("Passwords imported successfully.")
        except Exception as e:
            print(f"Error importing passwords: {e}")

    def export_passwords(self, csv_file):
        try:
            with open(csv_file, 'w', newline='') as file:
                fieldnames = ['service', 'username', 'password']
                writer = csv.DictWriter(file, fieldnames=fieldnames)
                writer.writeheader()
                for service, creds in self.passwords.items():
                    writer.writerow({'service': service, 'username': creds['username'], 'password': creds['password']})
            print(f"Passwords exported to {csv_file}.")
        except Exception as e:
            print(f"Error exporting passwords: {e}")

    def menu(self):
        while True:
            print("\nPxrtal Password Manager")
            print("1. Add Password")
            print("2. Get Password")
            print("3. Update Password")
            print("4. Delete Password")
            print("5. Search Passwords")
            print("6. Import Passwords from CSV")
            print("7. Export Passwords to CSV")
            print("8. Exit")
            choice = input("Choose an option: ").strip()
            if choice == '1':
                service = input("Enter service name: ").strip()
                username = input("Enter username: ").strip()
                password = getpass.getpass("Enter password: ").strip()
                self.add_password(service, username, password)
            elif choice == '2':
                service = input("Enter service name: ").strip()
                self.get_password(service)
            elif choice == '3':
                service = input("Enter service name: ").strip()
                username = input("Enter new username: ").strip()
                password = getpass.getpass("Enter new password: ").strip()
                self.update_password(service, username, password)
            elif choice == '4':
                service = input("Enter service name: ").strip()
                self.delete_password(service)
            elif choice == '5':
                keyword = input("Enter the keyword to search: ").strip()
                self.search_password(keyword)
            elif choice == '6':
                csv_file = input("Enter the CSV file path to import: ").strip()
                self.import_passwords(csv_file)
            elif choice == '7':
                csv_file = input("Enter the CSV file path to export: ").strip()
                self.export_passwords(csv_file)
            elif choice == '8':
                print("Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")

def main():
    password_manager = TerminalPasswordManager()
    password_manager.menu()

if __name__ == "__main__":
    main()