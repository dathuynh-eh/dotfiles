# Dotfiles

This repository contains my personal dotfiles and configuration for various development tools and environments. It's designed to be easily set up on new machines using GNU Stow for symlink management.

## 🛠️ Components

- **Shell**: Zsh with Oh My Zsh, including:

  - Starship prompt
  - Zsh autosuggestions
  - Zsh syntax highlighting
  - Zoxide for directory navigation

- **Terminal**: Multiple terminal emulator configurations

  - WezTerm
  - Ghostty

- **Editor**:

  - Neovim configuration
  - VSCode extensions and settings

- **Development Tools**:
  - Tmux for terminal multiplexing
  - Bat for better file previews
  - Various development tools (act, gitleaks, ripgrep, etc.)

## 📦 Package Management

The repository uses Homebrew for package management. The `Brewfile` contains all the necessary packages and applications.

### Backup packages

```shell
brew bundle dump --file=Brewfile --force
```

### Install packages

```shell
brew bundle --file=~/Brewfile
```

## 🚀 Quick Start

1. Clone this repository:

```shell
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
```

2. Install dependencies:

```shell
brew bundle --file=~/.dotfiles/Brewfile
```

3. Use GNU Stow to create symlinks:

```shell
cd ~/.dotfiles
stow .
```

## 📁 Directory Structure

- `zsh/`: Zsh configuration files
- `nvim/`: Neovim configuration
- `tmux/`: Tmux configuration
- `wezterm/`: WezTerm configuration
- `bat/`: Bat configuration
- `ghostty/`: Ghostty configuration

## 🔧 Configuration

Detailed configuration instructions can be found in the `CONFIGURATION.md` file.

## 📝 License

This project is licensed under the terms specified in the `LICENSE` file.

## 🤝 Contributing

Feel free to submit issues and enhancement requests!
