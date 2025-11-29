#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}› ${NC}$1"; }
success() { echo -e "${GREEN}✔ $1${NC}"; }

# Check if running as root (Arch usually runs makepkg as user, but pacman as root)
# We will use 'sudo' inside the script where necessary.
if [ "$EUID" -eq 0 ]; then
    echo "Please run this script as a NORMAL user (with sudo privileges), not root."
    exit 1
fi

log "Updating system..."
sudo pacman -Syu --noconfirm

log "Installing git and base-devel (required for AUR)..."
sudo pacman -S --needed --noconfirm git base-devel

# ==============================================================================
# 1. Install AUR Helper (yay)
#    This allows us to install everything (Official + AUR) with one command.
# ==============================================================================
if ! command -v yay &> /dev/null; then
    log "Installing yay (AUR helper)..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
else
    log "yay is already installed."
fi

# ==============================================================================
# 2. Main Installation
#    We install EVERYTHING via yay.
# ==============================================================================
log "Installing Packages..."

# List of packages mapping your Brewfile/Dotfiles to Arch packages
PACKAGES=(
    # --- System & Desktop (i3) ---
    "xorg-server" "xorg-xinit"  # Display server
    "i3-wm" "i3lock" "i3status" # Window manager
    "polybar"                   # Status bar
    "dunst"                     # Notifications
    "picom"                     # Compositor (transparency/blur)
    "rofi"                      # App launcher
    "feh"                       # Wallpaper setter
    "lxappearance"              # GTK theme switcher
    "thunar"                    # GUI File Manager
    "network-manager-applet"    # Wifi tray icon
    "pipewire" "pipewire-pulse" # Audio
    "ttf-font-awesome"          # Icons for Polybar

    # --- CLI Tools (Official Arch Repos) ---
    "git"
    "stow"
    "neovim"        # Latest version is in official repo
    "vim"
    "tmux"
    "fish"
    "starship"
    "zoxide"
    "fzf"
    "bat"           # Named correctly as 'bat'
    "fd"            # Named correctly as 'fd'
    "ripgrep"
    "eza"
    "yazi"          # Official repo! No cargo install needed
    "lazygit"       # Official repo!
    "github-cli"    # gh
    "tealdeer"      # Rust version of tldr
    "btop"
    "htop"
    "fastfetch"
    "jq"
    "poppler"       # PDF preview for yazi
    "ffmpeg"
    "imagemagick"
    "unzip"
    "wget"
    "man-db"
    "zsh"

    # --- Languages & Runtimes ---
    "go"
    "rustup"        # Toolchain manager for Rust
    "nodejs"
    "npm"
    "bun-bin"       # AUR

    # --- Development Tools ---
    "docker"
    "docker-compose"
    "lazydocker"    # AUR
    "k9s"           # Kubernetes CLI
    "tokei"         # Line counter

    # --- GUI Apps ---
    "alacritty"
    "firefox"
    "vscodium-bin"  # AUR (Binary version is faster to install)
    "zed"           # Official repo (recently added)
    "postman-bin"   # AUR
    "discord"
    "telegram-desktop"
    
    # --- Fonts (Nerd Fonts) ---
    "ttf-firacode-nerd"
    "ttf-jetbrains-mono-nerd"
)

# Install all packages in one go
# --needed skips already installed packages
# --noconfirm answers "yes" to everything
yay -S --needed --noconfirm "${PACKAGES[@]}"

# ==============================================================================
# 3. Post-Install Configuration
# ==============================================================================

log "Configuring Rust..."
if command -v rustup &> /dev/null; then
    rustup default stable
fi

log "Configuring Docker..."
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER

log "Setting default shell to Fish..."
# Add fish to shells list if not present
if ! grep -q "$(which fish)" /etc/shells; then
    which fish | sudo tee -a /etc/shells
fi
# Change shell
sudo chsh -s "$(which fish)" $USER

log "Cleaning up..."
yay -Yc --noconfirm # Remove unused dependencies

success "Installation Complete!"
log "Note: All packages (System, CLI, GUI, Fonts) are managed by Pacman/Yay."
log "To update everything in the future, simply run: yay"
