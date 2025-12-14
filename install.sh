#!/bin/bash

# ============================================================
# Super Saiyan Prompt - Installation Script
# Installs the full cinematic transformation experience!
# ============================================================

set -e

echo "⚡⚡⚡ Super Saiyan Prompt Installer - ULTRA INSTINCT EDITION ⚡⚡⚡"
echo "================================================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Check if Oh-My-Zsh is installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo -e "${RED}Error: Oh-My-Zsh is not installed!${NC}"
  echo "Please install Oh-My-Zsh first: https://ohmyz.sh/"
  exit 1
fi

echo -e "${GREEN}✓${NC} Oh-My-Zsh detected"

# Check for required tools
echo ""
echo -e "${CYAN}Checking dependencies...${NC}"

DEPS_OK=true

# Check for swww or hyprpaper
if ! command -v swww &> /dev/null && ! command -v hyprpaper &> /dev/null; then
  echo -e "${YELLOW}⚠${NC} Neither swww nor hyprpaper found"
  echo "  Wallpaper changing will be disabled"
  echo "  Install with: yay -S swww  (or hyprpaper)"
else
  if command -v swww &> /dev/null; then
    echo -e "${GREEN}✓${NC} swww found (wallpaper support enabled)"
  else
    echo -e "${GREEN}✓${NC} hyprpaper found (wallpaper support enabled)"
  fi
fi

# Check for audio player
if ! command -v mpv &> /dev/null && ! command -v paplay &> /dev/null; then
  echo -e "${YELLOW}⚠${NC} No audio player found (mpv or paplay)"
  echo "  Sound effects will be disabled"
  echo "  Install with: sudo pacman -S mpv"
else
  if command -v mpv &> /dev/null; then
    echo -e "${GREEN}✓${NC} mpv found (sound support enabled)"
  else
    echo -e "${GREEN}✓${NC} paplay found (sound support enabled)"
  fi
fi

echo ""

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create custom directories
mkdir -p "$HOME/.oh-my-zsh/custom/themes"
mkdir -p "$HOME/.oh-my-zsh/custom/plugins/ssj"

echo -e "${GREEN}✓${NC} Created Oh-My-Zsh custom directories"

# Create config directory
CONFIG_DIR="$HOME/.config/supersaiyan"
mkdir -p "$CONFIG_DIR"/{wallpapers/animated,sounds,ascii-art}

echo -e "${GREEN}✓${NC} Created config directory: $CONFIG_DIR"

# Copy theme file
echo ""
echo -e "${CYAN}Installing theme...${NC}"
cp "$SCRIPT_DIR/theme/supersaiyan.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/"
echo -e "${GREEN}✓${NC} Theme installed"

# Copy plugin
echo ""
echo -e "${CYAN}Installing plugin...${NC}"
cp "$SCRIPT_DIR/plugin/ssj.plugin.zsh" "$HOME/.oh-my-zsh/custom/plugins/ssj/ssj.plugin.zsh"
cp "$SCRIPT_DIR/plugin/_ssj" "$HOME/.oh-my-zsh/custom/plugins/ssj/"
echo -e "${GREEN}✓${NC} Plugin installed"

# Copy configuration file
if [[ ! -f "$CONFIG_DIR/ssj.config" ]]; then
  cp "$SCRIPT_DIR/ssj.config" "$CONFIG_DIR/"
  echo -e "${GREEN}✓${NC} Configuration file created"
else
  echo -e "${YELLOW}⚠${NC} Configuration file exists (keeping existing)"
fi

# Copy ASCII art
if [[ -d "$SCRIPT_DIR/assets/ascii-art" ]]; then
  cp "$SCRIPT_DIR/assets/ascii-art/"*.txt "$CONFIG_DIR/ascii-art/" 2>/dev/null || true
  echo -e "${GREEN}✓${NC} ASCII art installed"
fi

# Initialize state file
if [[ ! -f "$HOME/.ssj_prompt_state" ]]; then
  echo "1" > "$HOME/.ssj_prompt_state"
  echo -e "${GREEN}✓${NC} Initialized state file (default: SSJ1)"
else
  echo -e "${YELLOW}⚠${NC} State file exists (keeping current level)"
fi

# Check .zshrc configuration
echo ""
echo -e "${CYAN}Configuration Check${NC}"
echo "===================="

ZSHRC="$HOME/.zshrc"
NEEDS_CONFIG=false

# Check theme
if ! grep -q '^ZSH_THEME="supersaiyan"' "$ZSHRC" 2>/dev/null; then
  echo -e "${YELLOW}⚠${NC} Theme not configured in .zshrc"
  NEEDS_CONFIG=true
else
  echo -e "${GREEN}✓${NC} Theme already configured"
fi

# Check plugin
if ! grep -q 'plugins=.*ssj' "$ZSHRC" 2>/dev/null; then
  echo -e "${YELLOW}⚠${NC} Plugin not enabled in .zshrc"
  NEEDS_CONFIG=true
else
  echo -e "${GREEN}✓${NC} Plugin already enabled"
fi

if [[ "$NEEDS_CONFIG" == "true" ]]; then
  echo ""
  echo -e "${CYAN}Manual Configuration Required${NC}"
  echo "=============================="
  echo "Add the following to your ~/.zshrc:"
  echo ""
  echo -e "${YELLOW}ZSH_THEME=\"supersaiyan\"${NC}"
  echo ""
  echo "And add 'ssj' to your plugins list:"
  echo -e "${YELLOW}plugins=(git ... ssj)${NC}"
  echo ""
fi

# Asset setup
echo ""
echo -e "${CYAN}Asset Setup${NC}"
echo "==========="

ASSETS_FOUND=false

# Check for wallpapers
if ls "$CONFIG_DIR/wallpapers"/*.{jpg,png} &>/dev/null; then
  echo -e "${GREEN}✓${NC} Wallpapers found"
  ASSETS_FOUND=true
else
  echo -e "${YELLOW}⚠${NC} No wallpapers found"
fi

# Check for sounds
if ls "$CONFIG_DIR/sounds"/*.{mp3,wav,ogg} &>/dev/null; then
  echo -e "${GREEN}✓${NC} Sounds found"
  ASSETS_FOUND=true
else
  echo -e "${YELLOW}⚠${NC} No sounds found"
fi

if [[ "$ASSETS_FOUND" == "false" ]]; then
  echo ""
  echo -e "${MAGENTA}Would you like to download sample assets now?${NC}"
  read -p "Run asset downloader? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [[ -f "$SCRIPT_DIR/download-assets.sh" ]]; then
      bash "$SCRIPT_DIR/download-assets.sh"
    else
      echo -e "${YELLOW}⚠${NC} download-assets.sh not found"
    fi
  else
    echo ""
    echo "You can run it later with:"
    echo -e "${CYAN}  ./download-assets.sh${NC}"
  fi
fi

# Final instructions
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [[ "$NEEDS_CONFIG" == "true" ]]; then
  echo -e "${YELLOW}Next steps:${NC}"
  echo "  1. Update your ~/.zshrc as shown above"
  echo "  2. Reload your shell: source ~/.zshrc"
  echo "  3. Try it out: ssj 4 (ULTRA INSTINCT!)"
else
  echo -e "${YELLOW}Next step:${NC}"
  echo "  Reload your shell: ${CYAN}source ~/.zshrc${NC}"
  echo "  Try it out: ${CYAN}ssj 4${NC} (ULTRA INSTINCT!)"
fi

echo ""
echo -e "${CYAN}Configuration:${NC}"
echo "  Edit settings: ${YELLOW}ssj config${NC}"
echo "  Or manually:   ${YELLOW}$CONFIG_DIR/ssj.config${NC}"
echo ""

echo -e "${CYAN}Add your assets:${NC}"
echo "  Wallpapers (static): $CONFIG_DIR/wallpapers/"
echo "    (name: ssj1.jpg, ssj2.jpg, ssj3.jpg, ui.jpg)"
echo "  Wallpapers (animated): $CONFIG_DIR/wallpapers/animated/"
echo "    (name: ssj1.mp4, ssj2.mp4, ssj3.mp4, ui.mp4)"
echo "  Sounds: $CONFIG_DIR/sounds/"
echo "    (name: ssj1.mp3, ssj2.mp3, ssj3.mp3, ui.mp3)"
echo ""

echo -e "${CYAN}Usage:${NC}"
echo "  ssj 1      - Transform to SSJ1 (with full animation!)"
echo "  ssj 2      - Transform to SSJ2 (epic lightning!)"
echo "  ssj 3      - Transform to SSJ3 (MAXIMUM POWER!)"
echo "  ssj 4      - Transform to ULTRA INSTINCT! (8 seconds of INSANITY!)"
echo "  ssj ui     - Ultra Instinct (alias)"
echo "  ssj config - Customize your transformation"
echo "  ssj help   - Show all commands"
echo ""

echo -e "${MAGENTA}⚡⚡⚡ Power up your terminal! ⚡⚡⚡${NC}"
