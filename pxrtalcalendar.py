#!/usr/bin/env python3
import os
import json
import csv
from datetime import datetime, timedelta
from termcolor import colored

class TerminalCalendar:
    def __init__(self, file_path='calendar.json'):
        self.file_path = file_path
        self.events = self.load_events()

    def load_events(self):
        if os.path.exists(self.file_path):
            with open(self.file_path, 'r') as file:
                return json.load(file)
        return {}

    def save_events(self):
        with open(self.file_path, 'w') as file:
            json.dump(self.events, file, indent=4)

    def add_event(self, date_str, event, event_type, details):
        date = self.validate_date(date_str)
        if date:
            if date_str not in self.events:
                self.events[date_str] = []
            self.events[date_str].append({"event": event, "type": event_type, "details": details})
            self.save_events()
            print("Event added.")
        else:
            print("Invalid date format. Please use YYYY-MM-DD.")

    def list_events(self, date_str=None):
        events_to_list = self.events
        if date_str:
            date = self.validate_date(date_str)
            if date and date_str in self.events:
                events_to_list = {date_str: self.events[date_str]}
            else:
                print("Invalid date or no events for this date.")
                return
        if not events_to_list:
            print("No events found.")
            return
        for date_str, events in sorted(events_to_list.items()):
            print(f"{date_str}:")
            for idx, event in enumerate(events, 1):
                event_type = event["type"]
                event_text = f"  {idx}. {event['event']} [{event_type}] - {event['details']}"
                print(self.color_event(event_type, event_text))

    def color_event(self, event_type, event_text):
        colors = {
            "meeting": "green",
            "birthday": "cyan",
            "reminder": "yellow",
            "default": "white"
        }
        return colored(event_text, colors.get(event_type, "default"))

    def list_events_daily(self, date_str):
        self.list_events(date_str)

    def list_events_weekly(self, start_date_str):
        start_date = self.validate_date(start_date_str)
        if start_date:
            end_date = start_date + timedelta(days=6)
            date_range = [(start_date + timedelta(days=i)).strftime('%Y-%m-%d') for i in range(7)]
            for date_str in date_range:
                self.list_events(date_str)
        else:
            print("Invalid date format. Please use YYYY-MM-DD.")

    def list_events_monthly(self, month_str):
        try:
            start_date = datetime.strptime(month_str, '%Y-%m')
            end_date = (start_date + timedelta(days=31)).replace(day=1) - timedelta(days=1)
            date_range = [(start_date + timedelta(days=i)).strftime('%Y-%m-%d') for i in range((end_date - start_date).days + 1)]
            for date_str in date_range:
                self.list_events(date_str)
        except ValueError:
            print("Invalid month format. Please use YYYY-MM.")

    def update_event(self, date_str, event_index, new_event, new_event_type, new_details):
        date = self.validate_date(date_str)
        if date and date_str in self.events:
            try:
                self.events[date_str][event_index - 1] = {"event": new_event, "type": new_event_type, "details": new_details}
                self.save_events()
                print("Event updated.")
            except IndexError:
                print("Invalid event index.")
        else:
            print("Invalid date or no events for this date.")

    def delete_event(self, date_str, event_index):
        date = self.validate_date(date_str)
        if date and date_str in self.events:
            try:
                event = self.events[date_str].pop(event_index - 1)
                if not self.events[date_str]:
                    del self.events[date_str]
                self.save_events()
                print(f"Deleted event: {event['event']}")
            except IndexError:
                print("Invalid event index.")
        else:
            print("Invalid date or no events for this date.")

    def search_events(self, keyword):
        results = {}
        for date_str, events in self.events.items():
            matching_events = [event for event in events if keyword.lower() in event["event"].lower()]
            if matching_events:
                results[date_str] = matching_events
        if not results:
            print("No matching events found.")
        else:
            for date_str, events in sorted(results.items()):
                print(f"{date_str}:")
                for event in events:
                    event_type = event["type"]
                    event_text = f"  - {event['event']} [{event_type}] - {event['details']}"
                    print(self.color_event(event_type, event_text))

    def import_events(self, csv_file):
        try:
            with open(csv_file, 'r') as file:
                reader = csv.DictReader(file)
                for row in reader:
                    date_str = row['date']
                    event = row['event']
                    event_type = row['type']
                    details = row['details']
                    self.add_event(date_str, event, event_type, details)
            print("Events imported successfully.")
        except Exception as e:
            print(f"Error importing events: {e}")

    def export_events(self, csv_file):
        try:
            with open(csv_file, 'w', newline='') as file:
                fieldnames = ['date', 'event', 'type', 'details']
                writer = csv.DictWriter(file, fieldnames=fieldnames)
                writer.writeheader()
                for date_str, events in self.events.items():
                    for event in events:
                        writer.writerow({'date': date_str, 'event': event['event'], 'type': event['type'], 'details': event['details']})
            print(f"Events exported to {csv_file}.")
        except Exception as e:
            print(f"Error exporting events: {e}")

    def validate_date(self, date_str):
        try:
            return datetime.strptime(date_str, '%Y-%m-%d')
        except ValueError:
            return None

    def menu(self):
        while True:
            print("\nPxrtal Calendar")
            print("1. Add Event")
            print("2. List Events (Daily)")
            print("3. List Events (Weekly)")
            print("4. List Events (Monthly)")
            print("5. Update Event")
            print("6. Delete Event")
            print("7. Search Events")
            print("8. Import Events from CSV")
            print("9. Export Events to CSV")
            print("10. Exit")
            choice = input("Choose an option: ").strip()
            if choice == '1':
                date_str = input("Enter the date (YYYY-MM-DD): ").strip()
                event = input("Enter the event: ").strip()
                event_type = input("Enter the event type (meeting, birthday, reminder): ").strip().lower()
                details = input("Enter the event details: ").strip()
                self.add_event(date_str, event, event_type, details)
            elif choice == '2':
                date_str = input("Enter the date (YYYY-MM-DD): ").strip()
                self.list_events_daily(date_str)
            elif choice == '3':
                start_date_str = input("Enter the start date (YYYY-MM-DD): ").strip()
                self.list_events_weekly(start_date_str)
            elif choice == '4':
                month_str = input("Enter the month (YYYY-MM): ").strip()
                self.list_events_monthly(month_str)
            elif choice == '5':
                date_str = input("Enter the date (YYYY-MM-DD): ").strip()
                self.list_events(date_str)
                try:
                    event_index = int(input("Enter the event number to update: ").strip())
                    new_event = input("Enter the new event: ").strip()
                    new_event_type = input("Enter the new event type (meeting, birthday, reminder): ").strip().lower()
                    new_details = input("Enter the new event details: ").strip()
                    self.update_event(date_str, event_index, new_event, new_event_type, new_details)
                except ValueError:
                    print("Please enter a valid number.")
            elif choice == '6':
                date_str = input("Enter the date (YYYY-MM-DD): ").strip()
                self.list_events(date_str)
                try:
                    event_index = int(input("Enter the event number to delete: ").strip())
                    self.delete_event(date_str, event_index)
                except ValueError:
                    print("Please enter a valid number.")
            elif choice == '7':
                keyword = input("Enter the keyword to search: ").strip()
                self.search_events(keyword)
            elif choice == '8':
                csv_file = input("Enter the CSV file path to import: ").strip()
                self.import_events(csv_file)
            elif choice == '9':
                csv_file = input("Enter the CSV file path to export: ").strip()
                self.export_events(csv_file)
            elif choice == '10':
                print("Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")

def main():
    calendar_app = TerminalCalendar()
    calendar_app.menu()

if __name__ == "__main__":
    main()
