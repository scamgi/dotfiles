# ~/.config/fish/config.fish

# ------------------------------------------------------------------------------
# Environment Variables
#
# Set variables that should be available to all programs.
# The `-x` flag exports the variable.
# ------------------------------------------------------------------------------
set -x EDITOR vim
set -x VISUAL vim
set -U fish_greeting

# ------------------------------------------------------------------------------
# PATH Configuration
#
# Add custom directories to the system's PATH. Fish automatically handles
# duplicates, so you don't need to check if the path already exists.
# ------------------------------------------------------------------------------

# Homebrew (for macOS)
fish_add_path /opt/homebrew/bin

# Go
set -x GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"

# user local bin
fish_add_path /usr/local/bin

# path to flutter
set -gx PATH "$HOME/flutter/bin" $PATH

# ------------------------------------------------------------------------------
# Shell Initializations
#
# Load and initialize tools that integrate with the shell.
# ------------------------------------------------------------------------------

# Starship
starship init fish | source

# Init Zoxide
zoxide init fish | source

# Init fzf
fzf --fish | source

# Use fd instead of find for fzf
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Preview file content using bat (Catppuccin themed)
set -gx FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}'"

# ------------------------------------------------------------------------------
# Source Other Configuration Files
#
# Keep this file clean by sourcing other files for specific configs.
# ------------------------------------------------------------------------------
if test -f ~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end
