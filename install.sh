#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/harivansh-afk/nvim.git"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

echo -e "${GREEN}Installing harivansh-afk/nvim configuration...${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed. Please install git first.${NC}"
    exit 1
fi

# Check if nvim is installed
if ! command -v nvim &> /dev/null; then
    echo -e "${YELLOW}Neovim not found. Installing via appimage (no sudo required)...${NC}"

    cd /tmp
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    # Try to extract (works on most systems)
    ./nvim.appimage --appimage-extract > /dev/null 2>&1

    mkdir -p "$HOME/.local/bin"

    if [ -d "squashfs-root" ]; then
        # Use extracted version
        rm -rf "$HOME/.local/nvim"
        mv squashfs-root "$HOME/.local/nvim"
        ln -sf "$HOME/.local/nvim/AppRun" "$HOME/.local/bin/nvim"
        rm -f nvim.appimage
    else
        # Use appimage directly
        mv nvim.appimage "$HOME/.local/bin/nvim"
    fi

    # Add to PATH
    export PATH="$HOME/.local/bin:$PATH"

    # Add to shell rc files if not already there
    for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if [ -f "$rc" ]; then
            if ! grep -q '.local/bin' "$rc" 2>/dev/null; then
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc"
                echo -e "${GREEN}Added ~/.local/bin to PATH in $(basename $rc)${NC}"
            fi
        fi
    done

    cd - > /dev/null
fi

# Verify nvim installation
if ! command -v nvim &> /dev/null && [ ! -x "$HOME/.local/bin/nvim" ]; then
    echo -e "${RED}Failed to install neovim.${NC}"
    exit 1
fi

# Ensure PATH includes local bin
export PATH="$HOME/.local/bin:$PATH"

echo -e "${GREEN}Neovim version: $(nvim --version | head -1)${NC}"

# Backup existing config if it exists
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo -e "${YELLOW}Backing up existing nvim config to $BACKUP_DIR${NC}"
    mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
fi

# Ensure .config directory exists
mkdir -p "$HOME/.config"

# Clone the repository
echo -e "${GREEN}Cloning nvim config from $REPO_URL...${NC}"
git clone "$REPO_URL" "$NVIM_CONFIG_DIR"

# Create undodir
mkdir -p "$NVIM_CONFIG_DIR/undodir"

echo -e "${GREEN}Installation complete!${NC}"
echo ""
echo -e "${YELLOW}IMPORTANT: Run this to use nvim now:${NC}"
echo -e "  source ~/.bashrc && nvim"
echo ""
echo "Or start a new terminal session and run: nvim"
