#!/bin/bash

set -e

echo "☕️ Starting Catppuccin Mocha Rice Setup for Ubuntu..."

# 1. Update Repositories
echo "› Updating package lists..."
sudo apt update -y

# 2. Install Window Manager & Core Components
# i3-wm: The window manager (modern versions usually include gaps)
# polybar: Status bar
# rofi: App launcher
# picom: Compositor (transparency/shadows)
# dunst: Notification daemon
# feh: Wallpaper setter
# thunar: File manager (lightweight)
# lxappearance: Tool to select GTK themes/icons
echo "› Installing core components..."
sudo apt install -y i3-wm polybar rofi picom dunst feh thunar lxappearance

# 3. Install Utilities & Ricing Tools
# arandr: GUI for screen resolution/layout (generates xrandr scripts)
# flameshot: Screenshot tool
# network-manager-gnome: Provides nm-applet for the bar
# pulseaudio-utils: For volume control via bar
# papirus-icon-theme: A nice fallback icon theme
# fonts-font-awesome: Often needed for bar icons
echo "› Installing utilities..."
sudo apt install -y arandr flameshot network-manager-gnome pulseaudio-utils papirus-icon-theme fonts-font-awesome unzip build-essential git

# 4. Install Dependencies for Source Builds (if needed later)
# Specifically useful if we decide to compile a fork of Picom for better animations
echo "› Installing build dependencies..."
sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev

# 5. Set up Directories for Themes
mkdir -p ~/.themes
mkdir -p ~/.icons

# 6. Install Catppuccin GTK Theme (Mocha - Blue)
if [ ! -d "$HOME/.themes/Catppuccin-Mocha-Standard-Blue-Dark" ]; then
    echo "› Downloading Catppuccin GTK Theme..."
    TEMP_DIR=$(mktemp -d)
    wget -O "$TEMP_DIR/Catppuccin-Mocha.zip" https://github.com/catppuccin/gtk/releases/download/v0.7.0/Catppuccin-Mocha-Standard-Blue-Dark.zip
    unzip -q "$TEMP_DIR/Catppuccin-Mocha.zip" -d ~/.themes/
    rm -rf "$TEMP_DIR"
    echo "  - Installed to ~/.themes"
else
    echo "› Catppuccin GTK Theme already installed."
fi

# 7. Install Catppuccin Cursors (Mocha - Dark)
if [ ! -d "$HOME/.icons/Catppuccin-Mocha-Dark-Cursors" ]; then
    echo "› Downloading Catppuccin Cursors..."
    TEMP_DIR=$(mktemp -d)
    wget -O "$TEMP_DIR/Catppuccin-Cursors.zip" https://github.com/catppuccin/cursors/releases/download/v0.3.1/Catppuccin-Mocha-Dark-Cursors.zip
    unzip -q "$TEMP_DIR/Catppuccin-Cursors.zip" -d ~/.icons/
    rm -rf "$TEMP_DIR"
    echo "  - Installed to ~/.icons"
else
    echo "› Catppuccin Cursors already installed."
fi

# 8. Recommendation for Lock Screen
echo "› Note: For the lock screen, 'betterlockscreen' is recommended but requires 'i3lock-color'."
echo "› We will handle specific lock screen compilation separately if the default i3lock isn't enough."

echo "✅ Phase 1 Complete. Dependencies and Assets are ready."
