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
abbr --add g git
abbr --add gst "git status"
abbr --add ga "git add"
abbr --add gaa "git add -A"
abbr --add gcmsg "git commit -m"
abbr --add gp "git push"
abbr --add gl "git pull"
abbr --add gf "git fetch"
abbr --add gd "git diff"

# Lazygit - A terminal UI for git
abbr --add lg lazygit

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
