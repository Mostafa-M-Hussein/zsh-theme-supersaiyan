# Super Saiyan Prompt ⚡

A Dragon Ball Z-themed Zsh prompt and transformation system. Because your terminal deserves to go Super Saiyan too.

## What is this?

Ever wanted your terminal to transform like Goku? Now it can. This is a fully-featured Oh-My-Zsh theme with an interactive transformation system that changes your prompt, wallpaper, plays sounds, and shows epic animations.

### Features

- **4 Transformation Levels**: SSJ1, SSJ2, SSJ3, and Ultra Instinct
- **Animated Wallpapers**: Supports both static images and animated videos (via mpvpaper)
- **Sound Effects**: Transformation sounds for that authentic DBZ experience
- **Visual Effects**: Color waves, lightning bolts, energy aura, screen flashes, particle explosions
- **Terminal Effects**: Dynamic background colors, opacity pulses, matrix rain
- **Git Integration**: Shows your git branch and status in the prompt
- **Multi-monitor Support**: Works with Hyprland's multiple displays

## Preview

When you transform to SSJ3:

```
⚡⚡⚡ SUPER SAIYAN 3 TRANSFORMATION ⚡⚡⚡

    ∿∿∿   ▄▄▄▄▄▄▄▄▄▄▄   ∿∿∿
   ∿∿∿   ███████████████   ∿∿∿
        SUPER SAIYAN 3
      Power Level: 1,000,000+
         LIMITS: SURPASSED
```

## Installation

### Requirements

- Zsh with Oh-My-Zsh
- A modern terminal (Alacritty, Kitty, etc.)
- For wallpapers: `swww` or `hyprpaper` (Hyprland users)
- For animated wallpapers: `mpvpaper` (optional)
- For sound: `mpv`, `ffplay`, or `paplay`

### Quick Install

```bash
cd ~/
git clone https://github.com/Mostafa-M-Hussein/zsh-theme-supersaiyan.git
cd zsh-theme-supersaiyan
./install.sh
```

The installer will:
- Copy the theme to your Oh-My-Zsh themes directory
- Install the SSJ plugin
- Set up configuration files in `~/.config/supersaiyan/`

Then edit your `~/.zshrc` and set:

```bash
ZSH_THEME="supersaiyan"
plugins=(... ssj)
```

Reload your shell:

```bash
source ~/.zshrc
```

### Assets Setup

You'll need wallpapers and sounds for the full experience.

#### Wallpapers

Create `~/.config/supersaiyan/wallpapers/` and add:
- `ssj1.jpg` - Golden hair Goku
- `ssj2.jpg` - Spiky SSJ2 style
- `ssj3.jpg` - Long hair SSJ3
- `ui.jpg` - Silver/white Ultra Instinct

Good sources:
- [Wallhaven](https://wallhaven.cc) - Search "goku super saiyan"
- [Unsplash](https://unsplash.com) - Search "dragon ball"

#### Sounds

Create `~/.config/supersaiyan/sounds/` and add MP3 files:
- `ssj1.mp3`
- `ssj2.mp3`
- `ssj3.mp3`
- `ui.mp3`

Use `yt-dlp` to download transformation scenes from YouTube:

```bash
yt-dlp -x --audio-format mp3 "VIDEO_URL" -o ~/.config/supersaiyan/sounds/ssj1.mp3
```

#### Animated Wallpapers (Optional)

If you want animated video wallpapers:

1. Install `mpvpaper`
2. Create `~/.config/supersaiyan/wallpapers/animated/`
3. Add MP4 files: `ssj1.mp4`, `ssj2.mp4`, `ssj3.mp4`, `ui.mp4`

Edit `~/.config/supersaiyan/ssj.config` and set:

```bash
SSJ_WALLPAPER_MODE=animated  # or 'auto' to fallback to static
```

## Usage

Transform your terminal:

```bash
ssj 1    # Super Saiyan
ssj 2    # Super Saiyan 2
ssj 3    # Super Saiyan 3
ssj 4    # Ultra Instinct
ssj 0    # Reset to base form
```

Each transformation includes:
- Cinematic animation sequence
- Wallpaper change
- Sound effect
- Visual terminal effects
- ASCII art
- New prompt theme

### Transformation Effects

**SSJ1**: Golden aura, energy gathering, power level rising, screen flash

**SSJ2**: Electric lightning bolts, intense energy bursts, cyan effects

**SSJ3**: Maximum power display, rapid energy pulses, magenta effects, extended animation

**Ultra Instinct**: Peak transformation sequence, shockwave, particle explosion, power counter to infinity, matrix rain, screen shake, color inversion

## Configuration

Edit `~/.config/supersaiyan/ssj.config` to customize:

```bash
# Toggle features
SSJ_ENABLE_WALLPAPER=true
SSJ_ENABLE_SOUND=true
SSJ_ENABLE_ANIMATIONS=true

# Visual effects
SSJ_ENABLE_COLOR_WAVES=true
SSJ_ENABLE_LIGHTNING=true
SSJ_ENABLE_ENERGY_AURA=true
SSJ_ENABLE_CHARACTER_GLITCH=true
SSJ_ENABLE_OPACITY_PULSE=true
SSJ_ENABLE_TERMINAL_BG=true

# Wallpaper settings
SSJ_WALLPAPER_TOOL=swww
SSJ_WALLPAPER_MODE=auto

# Sound settings
SSJ_AUDIO_PLAYER=mpv
SSJ_SOUND_VOLUME=100
```

## Troubleshooting

**No wallpaper changing:**
- Make sure `swww` or `hyprpaper` is installed
- Check that wallpaper files exist in the right location
- For Hyprland users, make sure the daemon is running

**No sound:**
- Install `mpv`, `ffplay`, or `paplay`
- Check that sound files exist
- Verify audio isn't muted

**Animations not showing:**
- Your terminal might not support all ANSI escape sequences
- Try Alacritty or Kitty for best compatibility

**Animated wallpapers not working:**
- Install `mpvpaper`
- Make sure you're on Wayland (mpvpaper requires Wayland)
- Check that MP4 files exist and are valid

## File Structure

```
~/.config/supersaiyan/
├── ssj.config              # Main configuration
├── wallpapers/
│   ├── ssj1.jpg
│   ├── ssj2.jpg
│   ├── ssj3.jpg
│   ├── ui.jpg
│   └── animated/          # Optional
│       ├── ssj1.mp4
│       ├── ssj2.mp4
│       ├── ssj3.mp4
│       └── ui.mp4
├── sounds/
│   ├── ssj1.mp3
│   ├── ssj2.mp3
│   ├── ssj3.mp3
│   └── ui.mp3
└── ascii-art/             # Custom ASCII art (optional)
    ├── ssj1.txt
    ├── ssj2.txt
    ├── ssj3.txt
    └── ui.txt
```

## Credits

Made with ⚡ by a DBZ fan who spends way too much time customizing terminals.

## License

MIT License - do whatever you want with it. Share it, modify it, make it better.

If you make improvements, feel free to contribute back!
