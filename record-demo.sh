#!/bin/bash

# Super Saiyan GIF Demo Recording Script
# This script helps you record your transformations into GIF format

echo "⚡ Super Saiyan GIF Recording Helper ⚡"
echo ""
echo "Choose your recording method:"
echo ""
echo "Method 1: asciinema + agg (Recommended for terminal animations)"
echo "  - Records terminal session perfectly"
echo "  - Creates smooth animated GIFs"
echo "  - Install: sudo pacman -S asciinema, cargo install agg"
echo ""
echo "Method 2: Peek (Easy GUI screen recorder)"
echo "  - Simple point-and-click recording"
echo "  - Records your actual screen with wallpapers"
echo "  - Install: sudo pacman -S peek"
echo ""
echo "Method 3: wf-recorder + ffmpeg (Wayland native)"
echo "  - Best quality for Wayland/Hyprland"
echo "  - Records everything including wallpapers"
echo "  - Install: sudo pacman -S wf-recorder ffmpeg"
echo ""

read -p "Which method do you want to use? (1/2/3): " choice

case $choice in
  1)
    echo ""
    echo "Using asciinema + agg method..."
    echo ""

    # Check if asciinema is installed
    if ! command -v asciinema &> /dev/null; then
      echo "Installing asciinema..."
      sudo pacman -S asciinema
    fi

    # Check if agg is installed
    if ! command -v agg &> /dev/null; then
      echo "agg not found. Install it with: cargo install agg"
      echo "After installing, run this script again."
      exit 1
    fi

    echo "Starting recording in 3 seconds..."
    echo "Perform your transformations, then press Ctrl+D to stop."
    sleep 3

    # Record the session
    asciinema rec /tmp/ssj-demo.cast

    # Convert to GIF
    echo "Converting to GIF..."
    agg /tmp/ssj-demo.cast demo.gif

    echo ""
    echo "✅ GIF created: demo.gif"
    ;;

  2)
    echo ""
    echo "Using Peek method..."
    echo ""

    if ! command -v peek &> /dev/null; then
      echo "Installing Peek..."
      sudo pacman -S peek
    fi

    echo "Steps:"
    echo "1. Peek will open - position the recording area over your terminal"
    echo "2. Click 'Record' button"
    echo "3. Perform your transformations (ssj 1, ssj 2, etc.)"
    echo "4. Click 'Stop' in Peek"
    echo "5. Save as GIF"
    echo ""
    echo "Starting Peek in 3 seconds..."
    sleep 3
    peek &
    ;;

  3)
    echo ""
    echo "Using wf-recorder + ffmpeg method..."
    echo ""

    if ! command -v wf-recorder &> /dev/null; then
      echo "Installing wf-recorder..."
      sudo pacman -S wf-recorder ffmpeg
    fi

    echo "Recording will start in 3 seconds..."
    echo "Press Ctrl+C to stop recording."
    sleep 3

    # Record
    wf-recorder -f /tmp/ssj-demo.mp4

    # Convert to GIF
    echo ""
    echo "Converting to GIF..."
    ffmpeg -i /tmp/ssj-demo.mp4 -vf "fps=15,scale=1024:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 demo.gif

    echo ""
    echo "✅ GIF created: demo.gif"
    ;;

  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

echo ""
echo "📁 Location: $(pwd)/demo.gif"
echo ""
echo "Tips for best results:"
echo "  - Use a clean terminal without distractions"
echo "  - Record in fullscreen or windowed mode"
echo "  - Show transformations: ssj 1, wait, ssj 2, wait, ssj 3, wait, ssj 4"
echo "  - Keep it short (15-30 seconds max)"
echo ""
