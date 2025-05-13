#!/bin/bash

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"
OLD_WORKSTATION_DIR="$HOME/workspace/workstation"

echo "Installing utility scripts..."
echo "Scripts directory: $SCRIPTS_DIR"

mkdir -p ~/.local/bin

# First, clean up old symlinks from workstation
echo "Cleaning up old symlinks..."
for link in ~/.local/bin/*; do
    if [ -L "$link" ] && readlink "$link" | grep -q "$OLD_WORKSTATION_DIR"; then
        rm -f "$link"
        echo "  Removed old: $(basename $link)"
    fi
done

# Make all scripts executable
chmod +x "$SCRIPTS_DIR"/*.sh

# Create new symlinks for all scripts
echo "Creating symlinks..."
for script in "$SCRIPTS_DIR"/*.sh; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script" .sh)
        # Remove any existing symlink
        rm -f "$HOME/.local/bin/$script_name"
        # Create new symlink
        ln -sf "$script" "$HOME/.local/bin/$script_name"
        echo "  Linked: $script_name -> $script"
    fi
done

echo "✅ Scripts installed with symlinks to ~/.local/bin"
echo "   Total scripts: $(ls -1 $SCRIPTS_DIR/*.sh | wc -l)"
