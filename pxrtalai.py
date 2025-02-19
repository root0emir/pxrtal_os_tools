#!/usr/bin/env python3
import os
import requests

class TerminalChatBot:
    def __init__(self):
        self.api_key = "apikey"
        self.api_url = "https://api-inference.huggingface.co/models/gpt2"
        self.chat_history = []

    def generate_response(self, user_input):
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        payload = {
            "inputs": user_input,
            "options": {"wait_for_model": True}
        }
        response = requests.post(self.api_url, headers=headers, json=payload)
        if response.status_code == 200:
            return response.json()[0]["generated_text"]
        else:
            raise Exception(f"API request failed with status code {response.status_code}")

    def chat(self):
        print("Welcome to the Pxrtal AI - Type 'exit' to quit.")
        while True:
            user_input = input("You: ").strip()
            if user_input.lower() == 'exit':
                print("Goodbye!")
                break
            self.chat_history.append(f"You: {user_input}")
            try:
                response_text = self.generate_response(user_input)
                self.chat_history.append(f"AI: {response_text}")
                print(f"AI: {response_text}")
            except Exception as e:
                print(f"Error: {str(e)}")

    def save_chat(self, filename):
        with open(filename, 'w') as file:
            for line in self.chat_history:
                file.write(line + "\n")
        print(f"Chat saved to {filename}")

def main():
    chatbot = TerminalChatBot()
    chatbot.chat()
    save_option = input("Would you like to save the chat? (yes/no): ").strip().lower()
    if save_option == 'yes':
        filename = input("File name: ").strip()
        chatbot.save_chat(filename)

if __name__ == "__main__":
    main()
