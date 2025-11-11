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

# Ripgrep (rg)
if command_exists rg; then
  echo "  Ripgrep is already installed."
else
  echo "  Installing Ripgrep..."
  cargo install ripgrep
fi

# Bat
if command_exists bat; then
  echo "  Bat is already installed."
else
  echo "  Installing Bat..."
  cargo install bat
fi

# Exa
if command_exists exa; then
  echo "  Exa is already installed."
else
  echo "  Installing Exa..."
  cargo install exa
fi

echo "✅ Setup complete. All dependencies are installed and up to date."
