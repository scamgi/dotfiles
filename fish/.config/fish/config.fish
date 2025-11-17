# ~/.config/fish/config.fish

# ------------------------------------------------------------------------------
# Environment Variables
#
# Set variables that should be available to all programs.
# The `-x` flag exports the variable.
# ------------------------------------------------------------------------------
set -x EDITOR "vim"
set -x VISUAL "vim"
set -U fish_greeting

# ------------------------------------------------------------------------------
# PATH Configuration
#
# Add custom directories to the system's PATH. Fish automatically handles
# duplicates, so you don't need to check if the path already exists.
# ------------------------------------------------------------------------------

# Homebrew (for macOS)
fish_add_path "/opt/homebrew/bin"

# Rust (Cargo)
fish_add_path "$HOME/.cargo/bin"

# Bun JS Runtime
fish_add_path "$HOME/.bun/bin"

# Go
set -x GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"

# For Starship
# fish_add_path /usr/local/bin

# ------------------------------------------------------------------------------
# Shell Initializations
#
# Load and initialize tools that integrate with the shell.
# ------------------------------------------------------------------------------

# Starship Prompt - A customizable cross-shell prompt
if command -v starship &> /dev/null
    starship init fish | source
end


# ------------------------------------------------------------------------------
# Source Other Configuration Files
#
# Keep this file clean by sourcing other files for specific configs.
# ------------------------------------------------------------------------------
if test -f ~/.config/fish/alias.fish
    source ~/.config/fish/alias.fish
end

# You can add more files here as your configuration grows, for example:
# if test -f ~/.config/fish/functions.fish
#     source ~/.config/fish/functions.fish
# end
