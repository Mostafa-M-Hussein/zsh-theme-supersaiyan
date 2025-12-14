# Recording GIF Demos

## Quick Start

Run the helper script:

```bash
./record-demo.sh
```

Choose your preferred method and follow the prompts.

## Method 1: asciinema + agg (Best for terminal-only)

**Best for**: Pure terminal animations without wallpapers

**Install:**
```bash
sudo pacman -S asciinema
cargo install agg
```

**Record:**
```bash
# Start recording
asciinema rec demo.cast

# Perform transformations
ssj 1
# wait a bit
ssj 2
# wait a bit
ssj 3
# wait a bit
ssj 4

# Press Ctrl+D to stop

# Convert to GIF
agg demo.cast demo.gif
```

**Pros**: Perfect terminal rendering, small file size
**Cons**: Doesn't capture wallpaper changes

## Method 2: Peek (Easiest)

**Best for**: Quick screen recording with GUI

**Install:**
```bash
sudo pacman -S peek
```

**Record:**
```bash
peek
```

1. Position the recording area over your terminal
2. Click "Record"
3. Do your transformations
4. Click "Stop"
5. Save as GIF

**Pros**: Super easy, captures everything including wallpapers
**Cons**: Larger file sizes

## Method 3: wf-recorder + ffmpeg (Best quality)

**Best for**: Wayland/Hyprland users wanting full screen recording

**Install:**
```bash
sudo pacman -S wf-recorder ffmpeg
```

**Record:**
```bash
# Start recording
wf-recorder -f demo.mp4

# Do your transformations
ssj 1
ssj 2
ssj 3
ssj 4

# Press Ctrl+C to stop

# Convert to optimized GIF
ffmpeg -i demo.mp4 \
  -vf "fps=15,scale=1024:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
  -loop 0 demo.gif
```

**Pros**: Best quality, captures wallpapers, native Wayland
**Cons**: Requires conversion step

## Method 4: OBS Studio (Professional)

**Best for**: High-quality recordings with editing

**Install:**
```bash
sudo pacman -S obs-studio
```

**Record:**
1. Open OBS
2. Add "Screen Capture" source
3. Click "Start Recording"
4. Perform transformations
5. Click "Stop Recording"
6. Export to GIF using online tools or ffmpeg

## Tips for Great Demos

### Before Recording:
- Clear your terminal history: `clear`
- Set a clean wallpaper or use default
- Make terminal fullscreen or consistent size
- Close unnecessary windows

### During Recording:
- Wait 2-3 seconds between transformations
- Let animations complete fully
- Keep it under 30 seconds total
- Show variety: ssj 1 → ssj 2 → ssj 3 → ssj 4

### Demo Script Example:
```bash
# Clear screen
clear

# Show help briefly
ssj --help

# Wait 2 seconds
sleep 2

# Transform to SSJ1
ssj 1

# Wait for animation to complete
sleep 5

# Transform to SSJ2
ssj 2

# Wait
sleep 5

# Transform to SSJ3
ssj 3

# Wait
sleep 5

# Transform to Ultra Instinct
ssj 4

# Let final animation play
sleep 7
```

### Optimizing GIF Size:

If your GIF is too large, optimize it:

```bash
# Reduce fps and resolution
ffmpeg -i demo.gif -vf "fps=10,scale=800:-1:flags=lanczos" demo-small.gif

# Or use gifsicle
sudo pacman -S gifsicle
gifsicle -O3 --colors 256 demo.gif -o demo-optimized.gif
```

## Recommended Settings

For GitHub README:
- **Resolution**: 1024x768 or 1280x720
- **FPS**: 10-15
- **Duration**: 15-30 seconds
- **File size**: Under 10MB

For Reddit/Twitter:
- **Resolution**: 800x600
- **FPS**: 15
- **Duration**: 10-20 seconds
- **File size**: Under 5MB

## Adding GIF to README

Once you have your GIF:

```bash
# Copy GIF to repo
cp demo.gif /home/moado/Work/supersaiyan-prompt/demo.gif

# Add to git
git add demo.gif

# Commit
git commit -m "Add demo GIF"

# Push
git push
```

Then add to your README.md:

```markdown
## Demo

![Super Saiyan Transformation Demo](demo.gif)
```

Or link it from GitHub:

```markdown
## Demo

![Demo](https://raw.githubusercontent.com/Mostafa-M-Hussein/zsh-theme-supermaiyan/master/demo.gif)
```
