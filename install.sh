#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

REPO_URL="https://github.com/harivansh-afk/nvim.git"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"

install_appimage() {
    echo -e "${YELLOW}Installing neovim via appimage...${NC}"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    mkdir -p "$HOME/.local/bin"
    mv nvim.appimage "$HOME/.local/bin/nvim"
    export PATH="$HOME/.local/bin:$PATH"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo -e "${GREEN}Added ~/.local/bin to PATH in .bashrc${NC}"
}

echo -e "${GREEN}Installing harivansh-afk/nvim configuration...${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed. Please install git first.${NC}"
    exit 1
fi

# Check if nvim is installed
if ! command -v nvim &> /dev/null; then
    echo -e "${YELLOW}Neovim not found. Attempting to install...${NC}"

    if command -v apt-get &> /dev/null; then
        # Debian/Ubuntu - install latest from PPA or appimage
        echo "Detected Debian/Ubuntu..."
        if command -v sudo &> /dev/null; then
            sudo apt-get update || echo -e "${YELLOW}apt-get update had issues, continuing anyway...${NC}"
            sudo apt-get install -y neovim && NVIM_INSTALLED=true || NVIM_INSTALLED=false
            if [ "$NVIM_INSTALLED" = false ]; then
                echo -e "${YELLOW}apt install failed. Installing via appimage...${NC}"
                install_appimage
            fi
        else
            # No sudo - use appimage
            install_appimage
        fi
    elif command -v yum &> /dev/null; then
        # RHEL/CentOS
        echo "Detected RHEL/CentOS..."
        sudo yum install -y neovim || install_appimage
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        echo "Detected Arch Linux..."
        sudo pacman -S --noconfirm neovim || install_appimage
    elif command -v brew &> /dev/null; then
        # macOS with Homebrew
        echo "Detected macOS with Homebrew..."
        brew install neovim
    else
        # Fallback: download appimage
        install_appimage
    fi
fi

# Verify nvim installation
if ! command -v nvim &> /dev/null && [ ! -x "$HOME/.local/bin/nvim" ]; then
    echo -e "${RED}Failed to install neovim. Please install it manually.${NC}"
    exit 1
fi

# Use local bin nvim if system nvim not found
if ! command -v nvim &> /dev/null; then
    export PATH="$HOME/.local/bin:$PATH"
fi

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
echo -e "Run ${YELLOW}nvim${NC} to start Neovim."
echo "On first launch, lazy.nvim will automatically install all plugins."
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo -e "Your old config was backed up to: ${YELLOW}$BACKUP_DIR${NC}"
fi
