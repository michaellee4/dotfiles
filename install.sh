#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

symlink() {
    local src="$DOTFILES/$1"
    local dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [[ -d "$dst" && ! -L "$dst" ]]; then
        echo "WARNING: $dst is a real directory, skipping. Remove it manually and re-run."
        return
    fi
    ln -sf "$src" "$dst"
    echo "linked $dst -> $src"
}

# Yazi
symlink yazi "$HOME/.config/yazi"

# Shell
symlink .zshrc "$HOME/.zshrc"
symlink .zprofile "$HOME/.zprofile"

# Starship
symlink starship.toml "$HOME/.config/starship.toml"

# Borders
symlink borders "$HOME/.config/borders"

# AutoRaise
symlink AutoRaise "$HOME/.config/AutoRaise"

# Aerospace
symlink aerospace "$HOME/.config/aerospace"

# Kitty
symlink kitty "$HOME/.config/kitty"

# Neovim
symlink nvim "$HOME/.config/nvim"

# Sketchybar
symlink sketchybar "$HOME/.config/sketchybar"

# Git
symlink git "$HOME/.config/git"
