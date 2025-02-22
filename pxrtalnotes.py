#!/usr/bin/env python3
import os
import json
import csv
from datetime import datetime

class TerminalNotes:
    def __init__(self, file_path='notes.json'):
        self.file_path = file_path
        self.notes = self.load_notes()

    def load_notes(self):
        if os.path.exists(self.file_path):
            with open(self.file_path, 'r') as file:
                return json.load(file)
        return []

    def save_notes(self):
        with open(self.file_path, 'w') as file:
            json.dump(self.notes, file, indent=4)

    def add_note(self, note, tags, priority, date_time, note_type):
        self.notes.append({
            "note": note,
            "tags": tags,
            "priority": priority,
            "date_time": date_time,
            "type": note_type
        })
        self.save_notes()
        print("Note added.")

    def list_notes(self):
        if not self.notes:
            print("No notes found.")
            return
        for idx, note in enumerate(self.notes, 1):
            tags = ", ".join(note["tags"])
            print(f"{idx}. [{note['priority'].capitalize()}] {note['note']} [Tags: {tags}] [Date: {note['date_time']}] [Type: {note['type']}]")

    def update_note(self, note_index, new_note, new_tags, new_priority, new_date_time, new_type):
        try:
            self.notes[note_index - 1] = {
                "note": new_note,
                "tags": new_tags,
                "priority": new_priority,
                "date_time": new_date_time,
                "type": new_type
            }
            self.save_notes()
            print("Note updated.")
        except IndexError:
            print("Invalid note index.")

    def delete_note(self, note_index):
        try:
            note = self.notes.pop(note_index - 1)
            self.save_notes()
            print(f"Deleted note: {note['note']}")
        except IndexError:
            print("Invalid note index.")

    def search_notes(self, keyword):
        results = [note for note in self.notes if keyword.lower() in note["note"].lower()]
        if not results:
            print("No matching notes found.")
        else:
            for idx, note in enumerate(results, 1):
                tags = ", ".join(note["tags"])
                print(f"{idx}. [{note['priority'].capitalize()}] {note['note']} [Tags: {tags}] [Date: {note['date_time']}] [Type: {note['type']}]")

    def import_notes(self, csv_file):
        try:
            with open(csv_file, 'r') as file:
                reader = csv.DictReader(file)
                for row in reader:
                    note = row['note']
                    tags = row['tags'].split(',')
                    priority = row['priority']
                    date_time = row['date_time']
                    note_type = row['type']
                    self.add_note(note, tags, priority, date_time, note_type)
            print("Notes imported successfully.")
        except Exception as e:
            print(f"Error importing notes: {e}")

    def export_notes(self, csv_file):
        try:
            with open(csv_file, 'w', newline='') as file:
                fieldnames = ['note', 'tags', 'priority', 'date_time', 'type']
                writer = csv.DictWriter(file, fieldnames=fieldnames)
                writer.writeheader()
                for note in self.notes:
                    writer.writerow({
                        'note': note['note'],
                        'tags': ','.join(note['tags']),
                        'priority': note['priority'],
                        'date_time': note['date_time'],
                        'type': note['type']
                    })
            print(f"Notes exported to {csv_file}.")
        except Exception as e:
            print(f"Error exporting notes: {e}")

    def export_notes_html(self, html_file):
        try:
            with open(html_file, 'w') as file:
                file.write("<html><head><title>Notes</title></head><body><h1>Notes</h1><ul>")
                for note in self.notes:
                    tags = ", ".join(note["tags"])
                    file.write(f"<li><strong>{note['note']}</strong> [Priority: {note['priority']}] [Tags: {tags}] [Date: {note['date_time']}] [Type: {note['type']}]</li>")
                file.write("</ul></body></html>")
            print(f"Notes exported to {html_file}.")
        except Exception as e:
            print(f"Error exporting notes: {e}")

    def menu(self):
        while True:
            print("\nPxrtal Notes")
            print("1. Add Note")
            print("2. List Notes")
            print("3. Update Note")
            print("4. Delete Note")
            print("5. Search Notes")
            print("6. Import Notes from CSV")
            print("7. Export Notes to CSV")
            print("8. Export Notes to HTML")
            print("9. Exit")
            choice = input("Choose an option: ").strip()
            if choice == '1':
                note = input("Enter your note: ").strip()
                tags = input("Enter tags (comma-separated): ").strip().split(',')
                priority = input("Enter priority (low, medium, high): ").strip().lower()
                date_time = input("Enter date and time (YYYY-MM-DD HH:MM): ").strip()
                note_type = input("Enter type (event, reminder): ").strip().lower()
                self.add_note(note, tags, priority, date_time, note_type)
            elif choice == '2':
                self.list_notes()
            elif choice == '3':
                self.list_notes()
                try:
                    note_index = int(input("Enter the note number to update: ").strip())
                    new_note = input("Enter the new note: ").strip()
                    new_tags = input("Enter new tags (comma-separated): ").strip().split(',')
                    new_priority = input("Enter new priority (low, medium, high): ").strip().lower()
                    new_date_time = input("Enter new date and time (YYYY-MM-DD HH:MM): ").strip()
                    new_type = input("Enter new type (event, reminder): ").strip().lower()
                    self.update_note(note_index, new_note, new_tags, new_priority, new_date_time, new_type)
                except ValueError:
                    print("Please enter a valid number.")
            elif choice == '4':
                self.list_notes()
                try:
                    note_index = int(input("Enter the note number to delete: ").strip())
                    self.delete_note(note_index)
                except ValueError:
                    print("Please enter a valid number.")
            elif choice == '5':
                keyword = input("Enter the keyword to search: ").strip()
                self.search_notes(keyword)
            elif choice == '6':
                csv_file = input("Enter the CSV file path to import: ").strip()
                self.import_notes(csv_file)
            elif choice == '7':
                csv_file = input("Enter the CSV file path to export: ").strip()
                self.export_notes(csv_file)
            elif choice == '8':
                html_file = input("Enter the HTML file path to export: ").strip()
                self.export_notes_html(html_file)
            elif choice == '9':
                print("Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")

def main():
    notes_app = TerminalNotes()
    notes_app.menu()

if __name__ == "__main__":
    main()
