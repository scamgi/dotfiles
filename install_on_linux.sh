#!/bin/bash

# Stop execution on error
set -e

# Prevents popups (like "Service Restart" dialogs) during apt installation
export DEBIAN_FRONTEND=noninteractive

# Colors for logging
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${BLUE}› ${NC}$1"
}

success() {
    echo -e "${GREEN}✔ $1${NC}"
}

# Check for sudo/root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (sudo ./install_on_linux.sh)"
    exit
fi

log "Cleaning up broken PPA definitions..."
# FIX: Aggressively remove any source list file that contains 'fish-shell'
# This fixes the 404 error caused by the 'questing' codename
find /etc/apt/sources.list.d/ -name "*fish-shell*" -type f -delete
# Also try standard remove in case it's registered differently
if command -v add-apt-repository &> /dev/null; then
    add-apt-repository --remove -y ppa:fish-shell/release-3 || true
fi

log "Updating system and installing build essentials..."
apt update
apt upgrade -y
apt install -y build-essential curl wget git unzip tar software-properties-common

# ==============================================================================
# 1. Desktop Environment (i3) & System Utilities
# ==============================================================================
log "Installing i3 Window Manager and utilities..."
# Installing i3, Picom (compositor), Rofi (launcher), Dunst (notifications), Polybar
apt install -y i3 i3-wm i3lock xss-lock network-manager-gnome \
    picom rofi dunst polybar feh lxappearance \
    thunar # File manager (gui)

# ==============================================================================
# 2. CLI Tools (APT)
# ==============================================================================
log "Installing CLI tools via APT..."
apt install -y \
    stow \
    vim \
    tmux \
    pandoc \
    ncdu \
    fzf \
    parallel \
    ripgrep \
    ffmpeg \
    imagemagick \
    poppler-utils \
    htop \
    watch \
    zsh \
    libssl-dev pkg-config # Dependencies for Rust/Go builds

# Bat and Fd often have naming conflicts in Debian/Ubuntu
apt install -y bat fd-find

# Create symlinks to match standard names (batcat -> bat, fdfind -> fd)
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd

# ==============================================================================
# 3. Shells & Modern Replacements
# ==============================================================================
log "Installing Fish Shell..."
# We use the default repository version to avoid PPA codename errors
apt install -y fish

log "Installing Starship Prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

log "Installing Zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

log "Installing Bun..."
curl -fsSL https://bun.sh/install | bash

log "Installing TLDR..."
apt install -y tldr
tldr --update

# ==============================================================================
# 4. Programming Languages & Runtimes
# ==============================================================================
log "Installing Rust (Rustup)..."
if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
else
    log "Rust is already installed."
fi

log "Installing Go..."
snap install go --classic

log "Installing Node.js (via Snap for latest LTS)..."
snap install node --classic

# ==============================================================================
# 5. Cargo Packages (Rust Tools)
# ==============================================================================
log "Installing Rust-based tools (This may take a while)..."
# Ensure cargo path is available
export PATH="$HOME/.cargo/bin:$PATH"

cargo install tokei      # LOC counter
cargo install eza        # ls replacement
cargo install --locked yazi-fm  # File manager
cargo install --locked zellij   # Multiplexer (optional, similar to tmux)

# ==============================================================================
# 6. Specific Tools (Scripts/GitHub)
# ==============================================================================
log "Installing GitHub CLI..."
if ! command -v gh &> /dev/null; then
    mkdir -p -m 755 /etc/apt/keyrings
    wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
    chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    apt update 
    apt install -y gh
fi

log "Installing LazyGit & LazyDocker..."
go install margin.github.io/lazygit@latest
go install margin.github.io/lazydocker@latest

log "Installing K9s (Kubernetes UI)..."
snap install k9s

log "Installing Neovim (Latest via Snap)..."
snap install nvim --classic

# ==============================================================================
# 7. GUI Applications (Snap/Flatpak/Deb)
# ==============================================================================
log "Installing GUI Applications..."

# Browsers
log "Installing Browsers..."
snap install firefox
# Google Chrome (Handle manually as arch might be arm64 or amd64)
# We use a conditional check for architecture here
ARCH=$(dpkg --print-architecture)
if [ "$ARCH" = "amd64" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    log "Skipping Google Chrome (not supported on $ARCH via standard .deb)"
fi

# Development
log "Installing VSCode (VSCodium)..."
snap install codium --classic

log "Installing Postman..."
snap install postman

log "Installing Docker..."
# Using the convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $SUDO_USER
rm get-docker.sh

log "Installing Alacritty..."
# Use PPA only if we suspect it works, otherwise default to apt if available, or cargo
# Given previous errors, we will try apt first, then cargo if apt fails.
if apt-cache show alacritty > /dev/null 2>&1; then
    apt install -y alacritty
else
    log "Alacritty not in default repos, installing via Cargo (slow)..."
    apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    cargo install alacritty
fi

log "Installing Productivity Apps..."
snap install discord
snap install notion-snap-reborn # Unofficial snap for Notion
snap install telegram-desktop

# Zed Editor (Official script)
log "Installing Zed Editor..."
curl -f https://zed.dev/install.sh | sh

# ==============================================================================
# 8. Fonts (Nerd Fonts)
# ==============================================================================
log "Installing Fonts..."
FONT_DIR="/usr/local/share/fonts"
mkdir -p $FONT_DIR

# FiraCode Nerd Font
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip -o /tmp/FiraCode.zip -d $FONT_DIR
rm /tmp/FiraCode.zip

# JetBrainsMono as fallback for SF Mono
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d $FONT_DIR
rm /tmp/JetBrainsMono.zip

fc-cache -fv

# ==============================================================================
# 9. Cleanup
# ==============================================================================
log "Cleaning up..."
apt autoremove -y

success "Installation complete!"
