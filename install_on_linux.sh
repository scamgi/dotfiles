#!/bin/bash

# install packages of Brewfile

yay -Sy go \
  nodejs \
  starship \
  vim \
  tmux \
  pandoc \
  ncdu \
  github-cli \
  lazygit \
  kubectl \
  helm \
  tokei \
  fish \
  cbonsai \
  zoxide \
  fzf \
  parallel \
  yazi \
  neovim \
  tldr \
  eza \
  bat \
  fd \
  ripgrep \
  rust \
  fastfetch \
  htop
# watch \ # not available in yay
lazydocker \
  btop \
  k9s \
  nerd-fonts-fira-code \
  ttf-firacode-nerd \
  polybar

sudo pacman -S git-delta
sudo pacman -S ttf-jetbrains-mono # to install jetbrains mono

# install bun
curl -fsSL https://bun.sh/install | bash
