#!/usr/bin/env python3
import os
import pygame
import time
import random

class TerminalMusicPlayer:
    def __init__(self, music_directory='music'):
        self.music_directory = music_directory
        self.playlist = []
        self.current_track = None
        self.paused = False
        self.loop = False
        self.shuffle = False
        pygame.mixer.init()

    def load_music_files(self):
        if not os.path.exists(self.music_directory):
            os.makedirs(self.music_directory)
        self.playlist = [f for f in os.listdir(self.music_directory) if f.endswith('.mp3')]
        if not self.playlist:
            print("No music files found in the directory.")

    def play_music(self, track=None):
        if track:
            self.current_track = track
        if self.current_track and self.current_track in self.playlist:
            pygame.mixer.music.load(os.path.join(self.music_directory, self.current_track))
            pygame.mixer.music.play()
            print(f"Now playing: {self.current_track}")
        else:
            print("Track not found in playlist.")

    def pause_music(self):
        if not self.paused:
            pygame.mixer.music.pause()
            self.paused = True
            print("Music paused.")
        else:
            pygame.mixer.music.unpause()
            self.paused = False
            print("Music unpaused.")

    def stop_music(self):
        pygame.mixer.music.stop()
        self.current_track = None
        print("Music stopped.")

    def next_track(self):
        if self.current_track:
            current_index = self.playlist.index(self.current_track)
            if self.shuffle:
                next_index = random.randint(0, len(self.playlist) - 1)
            else:
                next_index = (current_index + 1) % len(self.playlist)
            self.play_music(self.playlist[next_index])

    def previous_track(self):
        if self.current_track:
            current_index = self.playlist.index(self.current_track)
            previous_index = (current_index - 1) % len(self.playlist)
            self.play_music(self.playlist[previous_index])

    def list_playlist(self):
        if not self.playlist:
            print("No music files found.")
            return
        print("Playlist:")
        for idx, track in enumerate(self.playlist, 1):
            print(f"{idx}. {track}")

    def toggle_loop(self):
        self.loop = not self.loop
        print(f"Loop mode {'enabled' if self.loop else 'disabled'}.")

    def toggle_shuffle(self):
        self.shuffle = not self.shuffle
        print(f"Shuffle mode {'enabled' if self.shuffle else 'disabled'}.")

    def set_volume(self, volume):
        pygame.mixer.music.set_volume(volume)
        print(f"Volume set to {int(volume * 100)}%.")

    def show_progress(self):
        if self.current_track:
            current_pos = pygame.mixer.music.get_pos() / 1000
            print(f"Current position: {time.strftime('%M:%S', time.gmtime(current_pos))}")

    def menu(self):
        self.load_music_files()
        while True:
            print("\nPxrtal Music Player")
            print("1. Play Music")
            print("2. Pause/Unpause Music")
            print("3. Stop Music")
            print("4. Next Track")
            print("5. Previous Track")
            print("6. List Playlist")
            print("7. Toggle Loop Mode")
            print("8. Toggle Shuffle Mode")
            print("9. Set Volume")
            print("10. Show Progress")
            print("11. Exit")
            choice = input("Choose an option: ").strip()
            if choice == '1':
                self.list_playlist()
                track_number = input("Enter track number to play: ").strip()
                try:
                    track_number = int(track_number) - 1
                    if 0 <= track_number < len(self.playlist):
                        self.play_music(self.playlist[track_number])
                    else:
                        print("Invalid track number.")
                except ValueError:
                    print("Please enter a valid number.")
            elif choice == '2':
                self.pause_music()
            elif choice == '3':
                self.stop_music()
            elif choice == '4':
                self.next_track()
            elif choice == '5':
                self.previous_track()
            elif choice == '6':
                self.list_playlist()
            elif choice == '7':
                self.toggle_loop()
            elif choice == '8':
                self.toggle_shuffle()
            elif choice == '9':
                volume = input("Enter volume (0-100): ").strip()
                try:
                    volume = int(volume) / 100
                    if 0 <= volume <= 1:
                        self.set_volume(volume)
                    else:
                        print("Volume must be between 0 and 100.")
                except ValueError:
                    print("Please enter a valid number.")
            elif choice == '10':
                self.show_progress()
            elif choice == '11':
                self.stop_music()
                print("Goodbye!")
                break
            else:
                print("Invalid choice. Please try again.")
            time.sleep(1)  # Small delay to prevent too fast looping

def main():
    music_player = TerminalMusicPlayer()
    music_player.menu()

if __name__ == "__main__":
    main()