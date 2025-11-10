#!/bin/bash

# A script to set up a new macOS machine for development.

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to check if a Homebrew package is installed
brew_package_installed() {
  brew list "$1" &> /dev/null
}

# --- Homebrew ---
echo "› Checking for Homebrew..."
if ! command_exists brew; then
  echo "  Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  Homebrew is already installed."
fi

# --- Essential Command-Line Tools ---
echo "› Installing essential command-line tools..."

# Git (usually pre-installed, but good to ensure it's the latest)
if brew_package_installed git; then
  echo "  Git is already installed."
else
  echo "  Installing Git..."
  brew install git
fi

# --- Development Languages and Runtimes ---
echo "› Installing development languages and runtimes..."

# Node.js and npm
if command_exists node; then
  echo "  Node.js is already installed."
else
  echo "  Installing Node.js and npm..."
  brew install node
fi

# Bun
if command_exists bun; then
  echo "  Bun is already installed."
else
  echo "  Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# Go
if command_exists go; then
  echo "  Go is already installed."
else
  echo "  Installing Go..."
  brew install go
fi

# Rust (rustc and cargo)
if command_exists rustc; then
  echo "  Rust is already installed."
else
  echo "  Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  # Add cargo to the path for the current session
  source "$HOME/.cargo/env"
fi


# --- Development Applications (via Homebrew Cask) ---
echo "› Installing development applications..."

# VSCodium
if [ -d "/Applications/VSCodium.app" ]; then
  echo "  VSCodium is already installed."
else
  echo "  Installing VSCodium..."
  brew install --cask vscodium
fi

# Docker
if [ -d "/Applications/Docker.app" ]; then
  echo "  Docker is already installed."
else
  echo "  Installing Docker..."
  brew install --cask docker
fi


echo "✅ All installations checked and up to date."
