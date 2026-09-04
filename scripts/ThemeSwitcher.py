#!/usr/bin/env python3

import os
import sys


# ============================================================
# Paths
# ============================================================

PROJECT_DIR = "/home/titan/.config/quickshell/X2-Shell"
CONFIG_DIR = PROJECT_DIR + "/config"
COLORS_FILE = CONFIG_DIR + "/Colors.qml"
THEMES_DIR = CONFIG_DIR + "/Themes"
BACKUP_FILE = CONFIG_DIR + "/Colors.qml.backup"


# ============================================================
# Get Themes
# ============================================================

def get_themes():
    if not os.path.isdir(THEMES_DIR):
        print("Error: Themes directory does not exist:")
        print(f"  {THEMES_DIR}")
        sys.exit(1)

    themes = []

    for file in os.listdir(THEMES_DIR):
        if file.lower().endswith(".qml"):
            theme_path = THEMES_DIR + "/" + file
            if os.path.isfile(theme_path):
                themes.append(theme_path)

    themes.sort()

    if not themes:
        print("No .qml themes found.")
        sys.exit(1)

    return themes


# ============================================================
# Show Themes
# ============================================================

def show_themes(themes):

    print()
    print("╭────────────────────────────────────────╮")
    print("│           X2 Themes Switcher           │")
    print("╰────────────────────────────────────────╯")
    print()

    for index, theme in enumerate(themes, start=1):
        theme_name = os.path.basename(theme)
        theme_name = theme_name.removesuffix(".qml")
        print(f"  {index}. {theme_name}")
    print()
    print("  0. Exit")
    print()


# ============================================================
# Select Theme
# ============================================================

def select_theme(themes):
    while True:
        try:
            choice = input("Select theme: ").strip()
            if choice == "0":
                print("Cancelled.")
                sys.exit(0)
            index = int(choice)
            if 1 <= index <= len(themes):
                return themes[index - 1]
            print("Invalid selection.")
        except ValueError:
            print("Please enter a number.")


# ============================================================
# Apply Theme
# ============================================================

def apply_theme(theme):
    if not os.path.isfile(COLORS_FILE):
        print("Error: Colors.qml does not exist:")
        print(f"  {COLORS_FILE}")
        sys.exit(1)
    with open(COLORS_FILE, "r") as file:
        colors_content = file.read()
    with open(BACKUP_FILE, "w") as file:
        file.write(colors_content)
    with open(theme, "r") as file:
        theme_content = file.read()
    with open(COLORS_FILE, "w") as file:
        file.write(theme_content)

    theme_name = os.path.basename(theme)
    theme_name = theme_name.removesuffix(".qml")

    print()
    print("Theme applied successfully!")
    print()
    print(f"  Theme : {theme_name}")
    print(f"  Source: {theme}")
    print(f"  Target: {COLORS_FILE}")
    print()
    print(f"  Backup: {BACKUP_FILE}")
    print()


# ============================================================
# Main
# ============================================================

def main():
    while True:
        themes = get_themes()
        show_themes(themes)
        selected_theme = select_theme(themes)
        apply_theme(selected_theme)


if __name__ == "__main__":
    main()