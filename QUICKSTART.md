# Super Saiyan Prompt - Quick Start Guide

## 5-Minute Setup

### 1. Install (2 minutes)

```bash
cd /home/moado/Work/supersaiyan-prompt
./install.sh
```

### 2. Update .zshrc (1 minute)

Add to `~/.zshrc`:

```bash
ZSH_THEME="supersaiyan"
plugins=(git ... ssj)
```

### 3. Reload Shell (10 seconds)

```bash
source ~/.zshrc
```

### 4. Add Assets (2 minutes)

**Option A: Quick test (no assets)**
```bash
ssj 3  # Works without wallpapers/sounds!
```

**Option B: Full experience**
```bash
./download-assets.sh  # Follow the guide
```

Then add:
- 3 wallpapers to: `~/.config/supersaiyan/wallpapers/`
  (name: ssj1.jpg, ssj2.jpg, ssj3.jpg)
- 3 sounds to: `~/.config/supersaiyan/sounds/`
  (name: ssj1.mp3, ssj2.mp3, ssj3.mp3)

### 5. Transform! (0 seconds)

```bash
ssj 1  # Golden warrior
ssj 2  # Electric power
ssj 3  # MAXIMUM POWER!
```

---

## Quick Commands

```bash
ssj 1/2/3   # Transform
ssj up      # Level up
ssj down    # Power down
ssj status  # Check level
ssj config  # Customize
ssj help    # Show help
```

---

## Quick Customization

```bash
# Edit config
ssj config

# Common tweaks:
SSJ_ANIMATION_DURATION=2       # Faster animations
SSJ_ENABLE_SOUND=false         # Mute sounds
SSJ_TRANSITION_TYPE=wipe       # Different wallpaper effect
SSJ_SOUND_VOLUME=80            # Louder!
```

---

## Quick Troubleshooting

**Wallpaper not changing?**
```bash
swww init  # Start swww daemon
```

**Sound not working?**
```bash
# Check if mpv is installed
which mpv

# Or install it
sudo pacman -S mpv
```

**Animation too slow?**
```bash
# Quick fix
SSJ_ANIMATION_DURATION=2 ssj 3
```

---

## What You Get

✓ Three awesome prompt designs
✓ Cinematic 4-5 second transformation animations
✓ ASCII art displays
✓ Wallpaper changes (swww/hyprpaper)
✓ Transformation sound effects
✓ Full customization options
✓ Tab completion
✓ Persistent state

---

## Resources

- Full docs: `README-ENHANCED.md`
- Config file: `~/.config/supersaiyan/ssj.config`
- Edit config: `ssj config`
- Download assets: `./download-assets.sh`

---

**Ready to power up?**

```bash
ssj 3
```

⚡⚡⚡
