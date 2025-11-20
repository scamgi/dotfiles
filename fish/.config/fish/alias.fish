# ~/.config/fish/alias.fish

# ------------------------------------------------------------------------------
# General & System
# ------------------------------------------------------------------------------
alias ls "eza --icons --git"
alias ll "eza --long --header --git --icons"
alias lt 'eza --long --tree --level=2 --icons'
alias l "eza --long --header --git --icons --all"
alias tree "eza --tree"
alias md "mkdir -p"

# Quick navigation
alias cd z
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

# ------------------------------------------------------------------------------
# Git & Development
#
# Based on your installed tools like git, lazygit, gh, etc.
# ------------------------------------------------------------------------------
alias g git
alias gst "git status"
alias ga "git add"
alias gaa "git add -A"
alias gcmsg "git commit -m"
alias gp "git push"
alias gl "git pull"
alias gf "git fetch"
alias gd "git diff"

# Lazygit - A terminal UI for git
alias lg lazygit

# ------------------------------------------------------------------------------
# Update script for macOS
# ------------------------------------------------------------------------------
function update
    echo "› Updating Homebrew..."
    brew update
    brew upgrade
    brew cleanup
    echo "✅ All updates complete."
end
