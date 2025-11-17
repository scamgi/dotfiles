# scamgi's Dotfiles

Welcome to my personal development environment configuration! This repository contains all the dotfiles and setup scripts I use for a consistent and efficient workflow across my machines.

## Overview

These dotfiles are designed to set up a development environment on macOS quickly. The setup for Linux is currently a work in progress. The installation script handles the installation of applications, command-line tools, and configurations for various tools like `fish`, `vim`, and `alacritty`.

## Installation

You can install this configuration with a single command. The script will automatically detect your operating system and run the appropriate installer.

```bash
curl -fsSL https://raw.githubusercontent.com/scamgi/dotfiles/main/install | bash
```

### Prerequisites

Before running the installation script, make sure you have the following dependencies installed:
*   `git`
*   `curl`

## How It Works

The main `install` script performs the following steps:
1.  Clones this repository to `~/.dotfiles`.
2.  Detects the operating system (macOS or Linux).
3.  Executes the corresponding installation script (`install_on_macOS.sh` or `install_on_linux.sh`).

The macOS script leverages **Homebrew** to manage most of the software installations via the `Brewfile` and uses **Stow** to symlink the configuration files from this repository into the correct locations.

## License

This project is open-source. Feel free to use, fork, or contribute to it.
