#!/usr/bin/env python3
import requests
import json
import pyfiglet
from termcolor import colored

class TerminalWeatherApp:
    def __init__(self, api_key):
        self.api_key = api_key
        self.base_url = "http://api.openweathermap.org/data/2.5/weather"
        self.forecast_url = "http://api.openweathermap.org/data/2.5/forecast"

    def get_weather_data(self, city):
        params = {'q': city, 'appid': self.api_key, 'units': 'metric'}
        response = requests.get(self.base_url, params=params)
        return response.json()

    def get_forecast_data(self, city):
        params = {'q': city, 'appid': self.api_key, 'units': 'metric'}
        response = requests.get(self.forecast_url, params=params)
        return response.json()

    def display_weather(self, weather_data):
        city = weather_data["name"]
        weather = weather_data["weather"][0]["description"]
        temp = weather_data["main"]["temp"]
        feels_like = weather_data["main"]["feels_like"]
        humidity = weather_data["main"]["humidity"]
        wind_speed = weather_data["wind"]["speed"]

        ascii_art = self.get_ascii_art(weather)
        print(pyfiglet.figlet_format(city))
        print(ascii_art)
        print(colored(f"Weather: {weather}", 'cyan'))
        print(colored(f"Temperature: {temp}°C", 'cyan'))
        print(colored(f"Feels Like: {feels_like}°C", 'cyan'))
        print(colored(f"Humidity: {humidity}%", 'cyan'))
        print(colored(f"Wind Speed: {wind_speed} m/s", 'cyan'))

    def display_forecast(self, forecast_data):
        city = forecast_data["city"]["name"]
        print(pyfiglet.figlet_format(f"{city} Forecast"))
        for forecast in forecast_data["list"][:8]:  # Display the next 24 hours forecast
            dt_txt = forecast["dt_txt"]
            weather = forecast["weather"][0]["description"]
            temp = forecast["main"]["temp"]
            feels_like = forecast["main"]["feels_like"]
            humidity = forecast["main"]["humidity"]
            wind_speed = forecast["wind"]["speed"]

            ascii_art = self.get_ascii_art(weather)
            print(colored(f"\n{dt_txt}", 'yellow'))
            print(ascii_art)
            print(colored(f"Weather: {weather}", 'cyan'))
            print(colored(f"Temperature: {temp}°C", 'cyan'))
            print(colored(f"Feels Like: {feels_like}°C", 'cyan'))
            print(colored(f"Humidity: {humidity}%", 'cyan'))
            print(colored(f"Wind Speed: {wind_speed} m/s", 'cyan'))

    def get_ascii_art(self, weather):
        if 'clear' in weather:
            return pyfiglet.figlet_format("Sunny")
        elif 'cloud' in weather:
            return pyfiglet.figlet_format("Cloudy")
        elif 'rain' in weather:
            return pyfiglet.figlet_format("Rain")
        elif 'snow' in weather:
            return pyfiglet.figlet_format("Snow")
        else:
            return pyfiglet.figlet_format("Weather")

    def menu(self):
        while True:
            print("\nPxrtal Weather ")
            print("1. Current Weather")
            print("2. 24-Hour Forecast")
            print("3. Exit")
            choice = input("Choose an option: ").strip()
            if choice == '1':
                city = input("Enter city name: ").strip()
                weather_data = self.get_weather_data(city)
                if weather_data["cod"] == 200:
                    self.display_weather(weather_data)
                else:
                    print("City not found.")
            elif choice == '2':
                city = input("Enter city name: ").strip()
                forecast_data = self.get_forecast_data(city)
                if forecast_data["cod"] == "200":
                    self.display_forecast(forecast_data)
                else:
                    print("City not found.")
            elif choice == '3':
                print("Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")

def main():
    api_key = "your_openweathermap_api_key"  # Replace with your OpenWeatherMap API key
    weather_app = TerminalWeatherApp(api_key)
    weather_app.menu()

if __name__ == "__main__":
    main()