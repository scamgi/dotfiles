#!/bin/bash

# --- Homebrew & Brewfile ---

# Homebrew installation

read -p 'Do you want to install homebrew? (Y/n) ' installhomebrew

if [[ -z "$installhomebrew" || "$installhomebrew" =~ ^[Yy]$ ]]; then
  echo "Installing homebrew."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed."
else
  echo "Skipped."
fi

# Run "brew bundle"

read -p 'Do you want run "brew bundle"? (Y/n) ' runbundle

if [[ -z "$runbundle" || "$runbundle" =~ ^[Yy]$ ]]; then
  echo "Running brew bundle..."
  brew bundle
  echo "Brew bundle finished."
else
  echo "Skipped."
fi

# Stow Configuration Files
read -p 'Do you want run stow? (Y/n) ' runstowchoice

if [[ -z "$runstowchoice" || "$runstowchoice" =~ ^[Yy]$ ]]; then
  echo "Running stow"

  PACKAGES=(
    "alacritty"
    "bat"
    "fish"
    "ghostty"
    "git"
    "nvim"
    "starship"
    "tmux"
    "vscodium"
    "yazi"
    "zed"
  )

  for package in "${PACKAGES[@]}"; do
    echo "Stowing $package..."
    stow -t "$HOME" "$package"
  done

  echo "Stowing done."
else
  echo "Skipped."
fi

# --- Create Fish Symlink for Compatibility ---
# This ensures /usr/local/bin/fish exists, pointing to the Apple Silicon
# Homebrew path. This allows consistent configs across architectures.

read -p 'Do you want to change default shell to fish? (Y/n) ' defaultshellchoice

if [[-z "$defaultshellchoice" || "$defaultshellchoice" =~ ^[Yy]$ ]]; then
  sudo mkdir -p /usr/local/bin
  [ ! -e "/usr/local/bin/fish" ] && sudo ln -s /opt/homebrew/bin/fish /usr/local/bin/fish

  echo "› Setting Fish as the default shell..."
  if ! grep -q "/usr/local/bin/fish" /etc/shells; then
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
  fi
  chsh -s /usr/local/bin/fish
else
  echo "Skipped."
fi

# ---

echo "✅ Setup complete. All dependencies are installed and up to date."
