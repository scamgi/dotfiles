# Start Starship
eval "$(starship init zsh)"

# bun completions
[ -s "/Users/polimi/.bun/_bun" ] && source "/Users/polimi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Load custom aliases
if [ -f "${HOME}/.aliases.zsh" ]; then
    source "${HOME}/.aliases.zsh"
fi

export PATH=$PATH:$(go env GOPATH)/bin
