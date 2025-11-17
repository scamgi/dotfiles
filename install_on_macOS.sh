#!/bin/bash

# A script to set up a new macOS machine for development.

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# --- Homebrew & Brewfile ---
echo "› Checking for Homebrew..."
if ! command_exists brew; then
  echo "  Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  Homebrew is already installed."
fi

echo "› Updating Homebrew and installing dependencies from Brewfile..."
# Navigate to the directory where the Brewfile is located
cd "$(dirname "$0")" || exit
# Install all dependencies from the Brewfile
brew bundle

# --- Other Installations (Not managed by Homebrew) ---

echo "› Installing tools not managed by Brewfile..."

# Bun
if command_exists bun; then
  echo "  Bun is already installed."
else
  echo "  Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# Rust (rustc and cargo)
if command_exists rustc; then
  echo "  Rust is already installed."
else
  echo "  Installing Rust..."
  # The -y flag skips the confirmation prompt
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Add cargo to the path for the current session to ensure subsequent commands can use it
source "$HOME/.cargo/env"


# --- Cargo-based tools ---
echo "› Installing Rust-based tools with cargo..."

cargo install ripgrep bat eza tokei

# --- Stow Configuration Files ---
echo "› Stowing configuration files..."

# stow kitty
stow alacritty
stow starship
stow vim
stow fish

echo "› Setting Fish as the default shell..."
if ! grep -q "/usr/local/bin/fish" /etc/shells; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /usr/local/bin/fish

echo "✅ Setup complete. All dependencies are installed and up to date."
