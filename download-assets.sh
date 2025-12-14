#!/bin/bash

# ============================================================
# Super Saiyan Prompt - Asset Download Helper
# Downloads sample wallpapers and transformation sounds
# ============================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${MAGENTA}⚡⚡⚡ Super Saiyan Asset Downloader ⚡⚡⚡${NC}"
echo "============================================="
echo ""

# Check dependencies
MISSING_DEPS=()

if ! command -v wget &> /dev/null && ! command -v curl &> /dev/null; then
  MISSING_DEPS+=("wget or curl")
fi

if ! command -v yt-dlp &> /dev/null && ! command -v youtube-dl &> /dev/null; then
  echo -e "${YELLOW}⚠ Note: yt-dlp/youtube-dl not found${NC}"
  echo "  Sound effects will be skipped (you can add your own later)"
  echo ""
fi

if [[ ${#MISSING_DEPS[@]} -gt 0 ]]; then
  echo -e "${RED}Missing dependencies:${NC}"
  for dep in "${MISSING_DEPS[@]}"; do
    echo "  - $dep"
  done
  echo ""
  echo "Install them and try again."
  exit 1
fi

# Set up directories
CONFIG_DIR="${HOME}/.config/supersaiyan"
WALLPAPER_DIR="${CONFIG_DIR}/wallpapers"
SOUND_DIR="${CONFIG_DIR}/sounds"
ASCII_DIR="${CONFIG_DIR}/ascii-art"

mkdir -p "$WALLPAPER_DIR" "$SOUND_DIR" "$ASCII_DIR"

# ============================================================
# Wallpaper URLs (High quality Dragon Ball wallpapers)
# ============================================================

echo -e "${CYAN}📥 Downloading wallpapers...${NC}"
echo ""

# Note: These are placeholder URLs. You'll need to replace with actual wallpaper URLs
# or the user can manually add their own wallpapers

WALLPAPERS_INFO="
To get the best results, please download your own Dragon Ball wallpapers!

Recommended sources:
  - wallhaven.cc (search: 'goku super saiyan')
  - reddit.com/r/dbz
  - deviantart.com (search: 'dragon ball wallpaper')

Suggested search terms:
  SSJ1: 'goku super saiyan golden'
  SSJ2: 'goku super saiyan 2 lightning'
  SSJ3: 'goku super saiyan 3 long hair'

Place your wallpapers in:
  $WALLPAPER_DIR/

Name them:
  ssj1.jpg (or .png)
  ssj2.jpg (or .png)
  ssj3.jpg (or .png)
"

echo -e "${YELLOW}${WALLPAPERS_INFO}${NC}"

read -p "Do you want to open wallhaven.cc in your browser to download wallpapers? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if command -v xdg-open &> /dev/null; then
    xdg-open "https://wallhaven.cc/search?q=goku+super+saiyan&categories=111&purity=100&sorting=relevance" &
  else
    echo "Open this URL: https://wallhaven.cc/search?q=goku+super+saiyan"
  fi
fi

echo ""

# ============================================================
# Sound Effects
# ============================================================

echo -e "${CYAN}🔊 Setting up transformation sounds...${NC}"
echo ""

if command -v yt-dlp &> /dev/null || command -v youtube-dl &> /dev/null; then
  DOWNLOADER="yt-dlp"
  if ! command -v yt-dlp &> /dev/null; then
    DOWNLOADER="youtube-dl"
  fi

  echo "You can download transformation sound effects from YouTube clips."
  echo ""
  echo "Recommended videos:"
  echo "  SSJ1: Search 'goku first super saiyan transformation'"
  echo "  SSJ2: Search 'gohan super saiyan 2 transformation'"
  echo "  SSJ3: Search 'goku super saiyan 3 transformation'"
  echo ""
  echo "Example command to extract audio:"
  echo -e "${YELLOW}  $DOWNLOADER -x --audio-format mp3 --audio-quality 0 <VIDEO_URL> -o '${SOUND_DIR}/ssj1.%(ext)s'${NC}"
  echo ""

  read -p "Do you want instructions for manual download? (y/n) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cat > "${CONFIG_DIR}/download-sounds-manual.sh" <<'EOFSCRIPT'
#!/bin/bash
# Manual sound download script
# Replace VIDEO_URL with actual YouTube URLs

SOUND_DIR="${HOME}/.config/supersaiyan/sounds"

# SSJ1 Transformation
echo "Downloading SSJ1 sound..."
# yt-dlp -x --audio-format mp3 --audio-quality 0 "SSJ1_VIDEO_URL" -o "${SOUND_DIR}/ssj1.%(ext)s"

# SSJ2 Transformation
echo "Downloading SSJ2 sound..."
# yt-dlp -x --audio-format mp3 --audio-quality 0 "SSJ2_VIDEO_URL" -o "${SOUND_DIR}/ssj2.%(ext)s"

# SSJ3 Transformation
echo "Downloading SSJ3 sound..."
# yt-dlp -x --audio-format mp3 --audio-quality 0 "SSJ3_VIDEO_URL" -o "${SOUND_DIR}/ssj3.%(ext)s"

echo "Done! Remove # from lines above and add your video URLs"
EOFSCRIPT
    chmod +x "${CONFIG_DIR}/download-sounds-manual.sh"
    echo -e "${GREEN}✓${NC} Created download script: ${CONFIG_DIR}/download-sounds-manual.sh"
    echo "  Edit this file to add your YouTube URLs"
  fi
else
  echo -e "${YELLOW}⚠ yt-dlp not installed, skipping audio download${NC}"
  echo "  You can manually add .mp3 files to: $SOUND_DIR"
fi

echo ""

# ============================================================
# Copy ASCII Art
# ============================================================

echo -e "${CYAN}🎨 Installing ASCII art...${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -d "${SCRIPT_DIR}/assets/ascii-art" ]]; then
  cp "${SCRIPT_DIR}/assets/ascii-art/"*.txt "$ASCII_DIR/" 2>/dev/null || true
  echo -e "${GREEN}✓${NC} ASCII art installed"
else
  echo -e "${YELLOW}⚠${NC} ASCII art not found in assets directory"
fi

echo ""

# ============================================================
# Summary
# ============================================================

echo -e "${GREEN}Asset setup complete!${NC}"
echo ""
echo "Directory structure:"
echo "  📁 $CONFIG_DIR"
echo "    ├── wallpapers/"
if ls "$WALLPAPER_DIR"/*.{jpg,png} &>/dev/null; then
  echo -e "    │   ${GREEN}✓ Wallpapers found${NC}"
else
  echo -e "    │   ${YELLOW}⚠ No wallpapers yet - add manually${NC}"
fi
echo "    ├── sounds/"
if ls "$SOUND_DIR"/*.{mp3,wav,ogg} &>/dev/null; then
  echo -e "    │   ${GREEN}✓ Sounds found${NC}"
else
  echo -e "    │   ${YELLOW}⚠ No sounds yet - add manually${NC}"
fi
echo "    └── ascii-art/"
if ls "$ASCII_DIR"/*.txt &>/dev/null; then
  echo -e "        ${GREEN}✓ ASCII art installed${NC}"
else
  echo -e "        ${YELLOW}⚠ No ASCII art${NC}"
fi

echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "  1. Add your wallpapers to: $WALLPAPER_DIR"
echo "     (name them: ssj1.jpg, ssj2.jpg, ssj3.jpg)"
echo ""
echo "  2. Add your sounds to: $SOUND_DIR"
echo "     (name them: ssj1.mp3, ssj2.mp3, ssj3.mp3)"
echo ""
echo "  3. Customize settings: ssj config"
echo ""
echo -e "${MAGENTA}⚡ Your transformation awaits! ⚡${NC}"
