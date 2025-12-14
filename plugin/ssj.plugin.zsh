# ============================================================
# Super Saiyan Plugin - MAXIMUM POWER EDITION
# With Epic Animations, Wallpapers, Sounds & Visual Effects!
# ============================================================

SSJ_STATE_FILE="${HOME}/.ssj_prompt_state"
SSJ_CONFIG_DIR="${HOME}/.config/supersaiyan"
SSJ_CONFIG_FILE="${SSJ_CONFIG_DIR}/ssj.config"

# ============================================================
# Configuration Loading
# ============================================================

ssj_load_config() {
  # Set defaults
  SSJ_ENABLE_ANIMATIONS=${SSJ_ENABLE_ANIMATIONS:-true}
  SSJ_ENABLE_WALLPAPER=${SSJ_ENABLE_WALLPAPER:-true}
  SSJ_ENABLE_SOUND=${SSJ_ENABLE_SOUND:-true}
  SSJ_ANIMATION_DURATION=${SSJ_ANIMATION_DURATION:-4}
  SSJ_SHOW_ASCII_ART=${SSJ_SHOW_ASCII_ART:-true}
  SSJ_WALLPAPER_TOOL=${SSJ_WALLPAPER_TOOL:-swww}
  SSJ_TRANSITION_TYPE=${SSJ_TRANSITION_TYPE:-fade}
  SSJ_TRANSITION_DURATION=${SSJ_TRANSITION_DURATION:-2}
  SSJ_AUDIO_PLAYER=${SSJ_AUDIO_PLAYER:-mpv}
  SSJ_SOUND_VOLUME=${SSJ_SOUND_VOLUME:-100}
  SSJ_CLEAR_SCREEN=${SSJ_CLEAR_SCREEN:-false}
  SSJ_SHOW_POWER_LEVEL=${SSJ_SHOW_POWER_LEVEL:-true}
  SSJ_COLOR_EFFECTS=${SSJ_COLOR_EFFECTS:-true}
  SSJ_SCREEN_FLASH=${SSJ_SCREEN_FLASH:-true}
  SSJ_TERMINAL_TITLE=${SSJ_TERMINAL_TITLE:-true}

  # Load config file if it exists
  if [[ -f "$SSJ_CONFIG_FILE" ]]; then
    source "$SSJ_CONFIG_FILE"
  fi

  # Set wallpaper paths with defaults
  SSJ1_WALLPAPER=${SSJ1_WALLPAPER:-"${SSJ_CONFIG_DIR}/wallpapers/ssj1.jpg"}
  SSJ2_WALLPAPER=${SSJ2_WALLPAPER:-"${SSJ_CONFIG_DIR}/wallpapers/ssj2.jpg"}
  SSJ3_WALLPAPER=${SSJ3_WALLPAPER:-"${SSJ_CONFIG_DIR}/wallpapers/ssj3.jpg"}

  # Set sound paths with defaults
  SSJ1_SOUND=${SSJ1_SOUND:-"${SSJ_CONFIG_DIR}/sounds/ssj1.mp3"}
  SSJ2_SOUND=${SSJ2_SOUND:-"${SSJ_CONFIG_DIR}/sounds/ssj2.mp3"}
  SSJ3_SOUND=${SSJ3_SOUND:-"${SSJ_CONFIG_DIR}/sounds/ssj3.mp3"}

  # Set ASCII art paths
  SSJ1_ASCII="${SSJ_CONFIG_DIR}/ascii-art/ssj1.txt"
  SSJ2_ASCII="${SSJ_CONFIG_DIR}/ascii-art/ssj2.txt"
  SSJ3_ASCII="${SSJ_CONFIG_DIR}/ascii-art/ssj3.txt"

  # Ultra Instinct settings (ALL EFFECTS ENABLED!)
  SSJ_UI_ENABLED=${SSJ_UI_ENABLED:-true}
  SSJ_UI_ANIMATION_DURATION=${SSJ_UI_ANIMATION_DURATION:-8}
  SSJ_UI_SHOCKWAVE=${SSJ_UI_SHOCKWAVE:-true}
  SSJ_UI_PARTICLES=${SSJ_UI_PARTICLES:-true}
  SSJ_UI_MATRIX_RAIN=${SSJ_UI_MATRIX_RAIN:-true}
  SSJ_UI_COLOR_INVERT=${SSJ_UI_COLOR_INVERT:-true}
  SSJ_UI_SCREEN_SHAKE=${SSJ_UI_SCREEN_SHAKE:-true}
  SSJ_UI_POWER_COUNTER=${SSJ_UI_POWER_COUNTER:-true}

  # UI paths
  UI_WALLPAPER=${UI_WALLPAPER:-"${SSJ_CONFIG_DIR}/wallpapers/ui.jpg"}
  UI_SOUND=${UI_SOUND:-"${SSJ_CONFIG_DIR}/sounds/ui.mp3"}
  UI_ASCII="${SSJ_CONFIG_DIR}/ascii-art/ui.txt"

  # Wallpaper Mode Settings (NEW!)
  SSJ_WALLPAPER_MODE=${SSJ_WALLPAPER_MODE:-auto}  # static, animated, or auto

  # Animated wallpaper paths (MP4 format)
  SSJ1_WALLPAPER_ANIMATED=${SSJ1_WALLPAPER_ANIMATED:-"${SSJ_CONFIG_DIR}/wallpapers/animated/ssj1.mp4"}
  SSJ2_WALLPAPER_ANIMATED=${SSJ2_WALLPAPER_ANIMATED:-"${SSJ_CONFIG_DIR}/wallpapers/animated/ssj2.mp4"}
  SSJ3_WALLPAPER_ANIMATED=${SSJ3_WALLPAPER_ANIMATED:-"${SSJ_CONFIG_DIR}/wallpapers/animated/ssj3.mp4"}
  UI_WALLPAPER_ANIMATED=${UI_WALLPAPER_ANIMATED:-"${SSJ_CONFIG_DIR}/wallpapers/animated/ui.mp4"}

  # mpvpaper options
  SSJ_MPVPAPER_OPTIONS=${SSJ_MPVPAPER_OPTIONS:-"--fork --mpv-options='--loop --panscan=1.0 --no-audio'"}

  # Enhanced Terminal Effects (NEW!)
  SSJ_ENABLE_COLOR_WAVES=${SSJ_ENABLE_COLOR_WAVES:-true}
  SSJ_ENABLE_LIGHTNING=${SSJ_ENABLE_LIGHTNING:-true}
  SSJ_ENABLE_ENERGY_AURA=${SSJ_ENABLE_ENERGY_AURA:-true}
  SSJ_ENABLE_CHARACTER_GLITCH=${SSJ_ENABLE_CHARACTER_GLITCH:-true}
  SSJ_ENABLE_OPACITY_PULSE=${SSJ_ENABLE_OPACITY_PULSE:-true}
  SSJ_ENABLE_UI_PEAK=${SSJ_ENABLE_UI_PEAK:-true}
  SSJ_ENABLE_TERMINAL_BG=${SSJ_ENABLE_TERMINAL_BG:-true}
}

# ============================================================
# Visual Effects Functions
# ============================================================

ssj_set_terminal_title() {
  local title=$1
  if [[ "$SSJ_TERMINAL_TITLE" == "true" ]]; then
    print -Pn "\e]0;${title}\a"
  fi
}

ssj_screen_flash() {
  local color=$1
  local times=${2:-3}

  if [[ "$SSJ_SCREEN_FLASH" != "true" ]]; then
    return
  fi

  # Screen flash effect using background color
  for ((i=0; i<times; i++)); do
    # Flash on
    print -Pn "\e[48;5;${color}m\e[2J\e[H"
    sleep 0.05
    # Flash off
    print -Pn "\e[0m\e[2J\e[H"
    sleep 0.05
  done
}

ssj_color_pulse() {
  local text=$1
  local color1=$2
  local color2=$3

  if [[ "$SSJ_COLOR_EFFECTS" != "true" ]]; then
    print -P "$text"
    return
  fi

  # Pulse between two colors
  for ((i=0; i<3; i++)); do
    print -Pn "\r%F{$color1}${text}%f"
    sleep 0.1
    print -Pn "\r%F{$color2}${text}%f"
    sleep 0.1
  done
  echo ""
}

# ============================================================
# ULTRA INSTINCT Visual Effects (ALL 6 EFFECTS!)
# ============================================================

ssj_shockwave_animation() {
  if [[ "$SSJ_UI_SHOCKWAVE" != "true" ]]; then
    return
  fi

  local color="255"  # White/silver

  # Expanding shockwave rings
  echo ""
  print -P "%F{$color}        ·%f"
  sleep 0.15
  print -P "%F{$color}       · · ·%f"
  sleep 0.15
  print -P "%F{$color}      · · · · ·%f"
  sleep 0.15
  print -P "%F{$color}     · · · · · · ·%f"
  sleep 0.15
  print -P "%F{$color}    · · · · · · · · ·%f"
  sleep 0.15
  print -P "%F{$color}   · · · · · · · · · · ·%f"
  sleep 0.15
}

ssj_particle_explosion() {
  if [[ "$SSJ_UI_PARTICLES" != "true" ]]; then
    return
  fi

  local color="255"

  # Particles bursting from center
  echo ""
  print -P "%F{$color}           ·%f"
  sleep 0.1
  print -P "%F{$color}        ·  ∴  ·%f"
  sleep 0.1
  print -P "%F{$color}      ∵  ·  ∴  ·  ∵%f"
  sleep 0.1
  print -P "%F{$color}    ∴  ∵  ·  ∴  ·  ∵  ∴%f"
  sleep 0.1
  print -P "%F{$color}  ∵  ∴  ∵  ·  ∴  ·  ∵  ∴  ∵%f"
  sleep 0.1
  print -P "%F{$color}∴  ∵  ∴  ∵  ·  ∴  ·  ∵  ∴  ∵  ∴%f"
  sleep 0.2
}

ssj_matrix_rain() {
  if [[ "$SSJ_UI_MATRIX_RAIN" != "true" ]]; then
    return
  fi

  local color="255"

  # Matrix-style character cascade
  echo ""
  print -P "%F{$color}╱ ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳%f"
  sleep 0.08
  print -P "%F{$color} ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱%f"
  sleep 0.08
  print -P "%F{$color}  ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱%f"
  sleep 0.08
  print -P "%F{$color}   ╱ ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱%f"
  sleep 0.08
  print -P "%F{$color}    ╲ ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱%f"
  sleep 0.08
  print -P "%F{$color}     ╳ ╱ ╲ ╳ ╱ ╲ ╳ ╱%f"
  sleep 0.08
}

ssj_screen_shake() {
  if [[ "$SSJ_UI_SCREEN_SHAKE" != "true" ]]; then
    return
  fi

  # Rapid cursor position changes to simulate shake
  for ((i=0; i<10; i++)); do
    # Move cursor around randomly
    print -Pn "\e[1A\e[2C"  # Up and right
    sleep 0.02
    print -Pn "\e[1B\e[2D"  # Down and left
    sleep 0.02
  done
}

ssj_color_invert() {
  if [[ "$SSJ_UI_COLOR_INVERT" != "true" ]]; then
    return
  fi

  # Screen color inversion flash (6 times!)
  for ((i=0; i<6; i++)); do
    printf '\e[?5h'  # Invert on
    sleep 0.06
    printf '\e[?5l'  # Invert off
    sleep 0.06
  done
}

ssj_power_counter() {
  if [[ "$SSJ_UI_POWER_COUNTER" != "true" ]]; then
    return
  fi

  local color="51"  # Cyan

  # Animated power level counter
  echo ""
  local levels=("1,000" "10,000" "100,000" "1,000,000" "10,000,000" "∞ IMMEASURABLE")

  for level in "${levels[@]}"; do
    print -Pn "\r%F{$color}Power Level: ${level}%f"
    sleep 0.15
  done
  echo ""
  sleep 0.3
}

# ============================================================
# Enhanced Terminal Effects (NEW!)
# ============================================================

ssj_color_wave() {
  if [[ "$SSJ_ENABLE_COLOR_WAVES" != "true" ]]; then
    return
  fi

  local direction=$1  # "horizontal" or "vertical"
  local colors=(226 220 214 208 202 196 160 124 88 52 16)  # Orange to red gradient

  if [[ "$direction" == "vertical" ]]; then
    # Sweep from top to bottom
    for color in "${colors[@]}"; do
      printf "\e[48;5;${color}m%*s\e[0m\n" $(tput cols) ""
      sleep 0.03
    done
  else
    # Horizontal sweep (fill line by line with gradient)
    local width=$(tput cols)
    for color in "${colors[@]}"; do
      printf "\e[48;5;${color}m%*s\e[0m\r" $width ""
      sleep 0.03
    done
    echo ""
  fi
}

ssj_lightning_flash() {
  if [[ "$SSJ_ENABLE_LIGHTNING" != "true" ]]; then
    return
  fi

  local duration=$1  # How many lightning strikes (default: 5)
  duration=${duration:-5}

  local lightning_chars=("╱" "╲" "│" "┃" "╿" "╽")
  local colors=(226 227 228 229 230 231)  # Yellow to white

  for ((i=0; i<duration; i++)); do
    # Random position
    local row=$((RANDOM % 10 + 1))
    local col=$((RANDOM % $(tput cols)))
    local color=${colors[$((RANDOM % ${#colors[@]}))]}

    # Draw lightning bolt
    tput cup $row $col
    for char in "${lightning_chars[@]}"; do
      print -Pn "%F{$color}${char}%f"
    done

    # Screen flash
    printf '\e[?5h'
    sleep 0.02
    printf '\e[?5l'

    sleep 0.1
  done

  # Clear lightning artifacts
  clear
}

ssj_energy_aura() {
  if [[ "$SSJ_ENABLE_ENERGY_AURA" != "true" ]]; then
    return
  fi

  local color=$1  # Main transformation color
  local pulses=$2  # Number of pulses (default: 3)
  pulses=${pulses:-3}

  local width=$(tput cols)
  local height=$(tput lines)

  for ((p=0; p<pulses; p++)); do
    # Save cursor position
    tput sc

    # Top border
    tput cup 0 0
    printf "\e[48;5;${color}m%*s\e[0m" $width ""

    # Bottom border
    tput cup $height 0
    printf "\e[48;5;${color}m%*s\e[0m" $width ""

    # Left and right borders
    for ((row=1; row<height; row++)); do
      tput cup $row 0
      printf "\e[48;5;${color}m \e[0m"
      tput cup $row $((width-1))
      printf "\e[48;5;${color}m \e[0m"
    done

    sleep 0.2

    # Fade out (clear borders)
    tput clear

    # Restore cursor
    tput rc

    sleep 0.1
  done
}

ssj_character_glitch() {
  if [[ "$SSJ_ENABLE_CHARACTER_GLITCH" != "true" ]]; then
    return
  fi

  local duration=$1  # Duration in deciseconds (default: 10 = 1 second)
  duration=${duration:-10}

  local glitch_chars=("▓" "▒" "░" "█" "▄" "▀" "■" "□" "●" "○")
  local colors=(196 202 208 214 220 226 190 154 118 82 46)  # Random colors

  for ((i=0; i<duration; i++)); do
    # Random position
    local row=$((RANDOM % $(tput lines)))
    local col=$((RANDOM % $(tput cols)))
    local char=${glitch_chars[$((RANDOM % ${#glitch_chars[@]}))]}
    local color=${colors[$((RANDOM % ${#colors[@]}))]}

    # Place glitch character
    tput cup $row $col
    print -Pn "%F{$color}${char}%f"

    sleep 0.05
  done
}

ssj_opacity_pulse() {
  if [[ "$SSJ_ENABLE_OPACITY_PULSE" != "true" ]]; then
    return
  fi

  local pulses=$1  # Number of pulses (default: 3)
  pulses=${pulses:-3}

  # Try opacity control (Alacritty/Kitty)
  # If not supported, will silently fail - that's okay
  for ((p=0; p<pulses; p++)); do
    # Fade to transparent
    for opacity in {100..60..5}; do
      printf '\e]11;rgba:0/0/0/%d\e\\' $((opacity * 255 / 100))
      sleep 0.02
    done

    # Fade to opaque
    for opacity in {60..100..5}; do
      printf '\e]11;rgba:0/0/0/%d\e\\' $((opacity * 255 / 100))
      sleep 0.02
    done
  done
}

ssj_ui_peak_transformation() {
  if [[ "$SSJ_ENABLE_UI_PEAK" != "true" ]]; then
    return
  fi

  # Hide cursor
  tput civis 2>/dev/null

  echo ""
  echo ""
  print -P "%F{255}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%f"
  print -P "%F{51}     ⟨⟨⟨ PEAK TRANSFORMATION ⟩⟩⟩%f"
  print -P "%F{255}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%f"
  echo ""

  # Stage 1: Opacity pulse (0.6s)
  ssj_opacity_pulse 3

  # Stage 2: Energy aura explosion (0.8s)
  ssj_energy_aura "51" 4  # Cyan aura

  # Stage 3: Lightning storm (1s)
  ssj_lightning_flash 8

  # Stage 4: Color wave cascade (1s)
  ssj_color_wave "vertical"

  # Stage 5: Ultimate color explosion - rapid cycling through rainbow colors
  local colors=(196 202 208 214 220 226 190 154 118 82 46 47 48 49 50 51)
  for ((i=0; i<30; i++)); do
    local color=${colors[$((i % ${#colors[@]}))]}

    # Full screen color flash
    printf "\e[48;5;${color}m\e[2J\e[H"

    # Glitch overlay
    for ((g=0; g<5; g++)); do
      local row=$((RANDOM % $(tput lines)))
      local col=$((RANDOM % $(tput cols)))
      tput cup $row $col
      print -Pn "%F{255}⚡%f"
    done

    sleep 0.04
  done

  # Stage 6: Final brilliant white flash
  for ((i=0; i<5; i++)); do
    printf '\e[?5h'  # Invert on
    sleep 0.05
    printf '\e[?5l'  # Invert off
    sleep 0.05
  done

  # Reset and clear
  printf "\e[0m\e[2J\e[H"

  # Dramatic pause
  sleep 0.5

  # Show final message with pulsing effect
  echo ""
  ssj_color_pulse "    ⟨⟨⟨ MASTERY ACHIEVED ⟩⟩⟩" "255" "51"
  echo ""

  # Show cursor
  tput cnorm 2>/dev/null
}

# Change terminal background color
# Works with Alacritty, Kitty, and other modern terminals
ssj_change_terminal_bg() {
  local level=$1

  if [[ "$SSJ_ENABLE_TERMINAL_BG" != "true" ]]; then
    return
  fi

  # Define colors for each level (visible colors matching transformation)
  local bg_color

  case "$level" in
    1)
      # SSJ1: Golden/Yellow background
      bg_color="#2a2000"  # Visible golden
      ;;
    2)
      # SSJ2: Electric Blue background
      bg_color="#002a40"  # Visible electric blue
      ;;
    3)
      # SSJ3: Magenta/Pink background
      bg_color="#2a002a"  # Visible magenta
      ;;
    4|ui)
      # Ultra Instinct: Silver/White background
      bg_color="#2a2a35"  # Visible blue-silver
      ;;
    0|reset)
      # Reset to default
      bg_color="#000000"
      ;;
    *)
      return
      ;;
  esac

  # OSC 11 - Set background color (try both terminators for compatibility)
  printf "\e]11;${bg_color}\e\\"
  printf "\e]11;${bg_color}\a"
}

# Animated terminal background transition with pulsing effect
ssj_animate_terminal_bg() {
  local level=$1

  if [[ "$SSJ_ENABLE_TERMINAL_BG" != "true" ]]; then
    return
  fi

  # Pulse effect: gradually increase intensity then settle
  local colors

  case "$level" in
    1)
      # SSJ1: Golden pulse - from black to golden
      colors=("#000000" "#0a0800" "#1a1000" "#2a2000" "#2a2000")
      ;;
    2)
      # SSJ2: Electric Blue pulse - from black to blue
      colors=("#000000" "#001020" "#00202f" "#002a40" "#002a40")
      ;;
    3)
      # SSJ3: Magenta pulse - from black to magenta
      colors=("#000000" "#0a000a" "#1a001a" "#2a002a" "#2a002a")
      ;;
    4|ui)
      # Ultra Instinct: Silver pulse - from black to silver
      colors=("#000000" "#0a0a15" "#1a1a25" "#2a2a35" "#2a2a35")
      ;;
    *)
      return
      ;;
  esac

  # Pulse through color intensities
  for color in "${colors[@]}"; do
    printf "\e]11;${color}\e\\"
    printf "\e]11;${color}\a"
    sleep 0.15
  done
}

# ============================================================
# Animation Functions
# ============================================================

ssj_print_color() {
  local text=$1
  local color=$2
  if [[ "$SSJ_COLOR_EFFECTS" == "true" ]]; then
    print -P "%F{$color}${text}%f"
  else
    print -P "$text"
  fi
}

ssj_show_ascii_art() {
  local ascii_file=$1
  local color=$2

  if [[ -f "$ascii_file" && "$SSJ_SHOW_ASCII_ART" == "true" ]]; then
    if [[ "$SSJ_COLOR_EFFECTS" == "true" ]]; then
      while IFS= read -r line; do
        print -P "%F{$color}${line}%f"
      done < "$ascii_file"
    else
      cat "$ascii_file"
    fi
  fi
}

ssj_loading_animation() {
  local duration=$1
  local color=$2
  local steps=$((duration * 4))  # 4 frames per second

  for ((i=1; i<=steps; i++)); do
    local progress=$((i * 100 / steps))
    local filled=$((progress / 5))
    local empty=$((20 - filled))

    # Build progress bar with pulsing effect
    local bar="["
    for ((j=0; j<filled; j++)); do bar+="━"; done
    for ((j=0; j<empty; j++)); do bar+="─"; done
    bar+="]"

    # Print progress with color pulsing
    printf "\r"
    if [[ $((i % 2)) -eq 0 ]]; then
      ssj_print_color "  Power Level Rising... $bar $progress%%" "$color"
    else
      # Alternate color for pulse effect
      local alt_color=$((color + 2))
      ssj_print_color "  Power Level Rising... $bar $progress%%" "$alt_color"
    fi
    sleep 0.25
  done
  echo ""
}

ssj_energy_burst() {
  local level=$1
  local color=$2

  if [[ "$SSJ_COLOR_EFFECTS" != "true" ]]; then
    return
  fi

  case $level in
    1)
      # Screen flash for SSJ1
      ssj_screen_flash "226" 2

      print -P "%F{$color}        ✦ ✦ ✦ ✦ ✦%f"
      sleep 0.2
      print -P "%F{$color}      ✦ ✦ ✦ ✦ ✦ ✦ ✦%f"
      sleep 0.2
      print -P "%F{$color}    ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦%f"
      sleep 0.2
      ;;
    2)
      # More intense flash for SSJ2
      ssj_screen_flash "51" 3

      print -P "%F{$color}        ⚡ ⚡ ⚡ ⚡ ⚡%f"
      sleep 0.15
      print -P "%F{$color}      ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡%f"
      sleep 0.15
      print -P "%F{$color}    ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡%f"
      sleep 0.15
      print -P "%F{$color}  ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡ ⚡%f"
      sleep 0.15
      ;;
    3)
      # MAXIMUM flash for SSJ3
      ssj_screen_flash "201" 4

      for ((i=0; i<4; i++)); do
        print -P "%F{$color}    ∿∿∿ ⚡⚡⚡ ∿∿∿ ⚡⚡⚡ ∿∿∿%f"
        sleep 0.1
        print -P "%F{201}  ∿∿∿ ⚡⚡⚡ ∿∿∿ ⚡⚡⚡ ∿∿∿ ⚡⚡⚡%f"
        sleep 0.1
      done
      ;;
  esac
}

# ============================================================
# Wallpaper Functions
# ============================================================

# Parse command-line arguments for wallpaper mode overrides
ssj_parse_args() {
  # Parse flags from arguments
  SSJ_WALLPAPER_MODE_OVERRIDE=""

  for arg in "$@"; do
    case "$arg" in
      --animated)
        SSJ_WALLPAPER_MODE_OVERRIDE="animated"
        ;;
      --static)
        SSJ_WALLPAPER_MODE_OVERRIDE="static"
        ;;
    esac
  done
}

# Get the active wallpaper mode (command override or config default)
ssj_get_wallpaper_mode() {
  # Command-line override takes precedence
  if [[ -n "$SSJ_WALLPAPER_MODE_OVERRIDE" ]]; then
    echo "$SSJ_WALLPAPER_MODE_OVERRIDE"
    return
  fi

  # Use config setting
  echo "${SSJ_WALLPAPER_MODE:-auto}"
}

# Change wallpaper using mpvpaper (animated)
ssj_change_wallpaper_mpvpaper() {
  local video_path=$1

  if [[ ! -f "$video_path" ]]; then
    return 1  # File doesn't exist, fallback
  fi

  if ! command -v mpvpaper &> /dev/null; then
    return 1  # mpvpaper not installed, fallback
  fi

  # FORCE BLACK SCREEN FIRST - before killing anything!
  # Start swww daemon if not running and set black IMMEDIATELY
  if command -v swww &> /dev/null; then
    if ! pgrep -x swww-daemon > /dev/null; then
      swww-daemon &> /dev/null &
      sleep 0.2
    fi

    # Set black background BEFORE killing old wallpaper
    swww clear 000000 &> /dev/null
    sleep 0.15  # Ensure black is FULLY visible
  fi

  # NOW kill old wallpapers (black is already showing)
  pkill -f "mpvpaper" &> /dev/null

  # Brief opacity pulse for smooth transition
  ssj_opacity_pulse 1 &

  # Small wait for smooth transition
  sleep 0.15

  # Get monitor names for Hyprland
  local monitors=$(hyprctl monitors -j 2>/dev/null | jq -r '.[].name' 2>/dev/null)

  if [[ -z "$monitors" ]]; then
    # Fallback: try common monitor names
    monitors="eDP-1 HDMI-A-1"
  fi

  # Start mpvpaper for each monitor WHILE swww still shows black
  for monitor in $monitors; do
    # Start mpvpaper with proper argument structure
    # mpvpaper needs: mpvpaper [options] <monitor> <video>
    # Important: --mpv-options uses = and quotes around the mpv options
    mpvpaper --fork \
      --mpv-options="--loop-file=inf --panscan=1.0 --no-audio" \
      "$monitor" \
      "$video_path" &> /dev/null &
  done

  # Give mpvpaper TIME to load and start displaying (1 second)
  # This keeps swww showing black until mpvpaper is ready
  sleep 1.0

  # NOW kill swww-daemon (mpvpaper should be fully displaying)
  pkill -f "swww-daemon" &> /dev/null

  return 0
}

# Change wallpaper using swww/hyprpaper (static)
ssj_change_wallpaper_static() {
  local wallpaper=$1

  if [[ ! -f "$wallpaper" ]]; then
    return
  fi

  case "$SSJ_WALLPAPER_TOOL" in
    swww)
      if command -v swww &> /dev/null; then
        # Check if swww daemon is running, start if not
        if ! pgrep -x swww-daemon > /dev/null; then
          swww-daemon &> /dev/null &
          sleep 0.2
        fi

        # FORCE BLACK SCREEN FIRST - before killing anything
        swww clear 000000 &> /dev/null
        sleep 0.2  # Ensure black is FULLY visible

        # NOW kill old mpvpaper instances
        pkill -f "mpvpaper" &> /dev/null

        # Opacity pulse for smooth transition
        ssj_opacity_pulse 1 &

        # Small wait for smooth effect
        sleep 0.1

        # Start new wallpaper - this will load while black is showing
        swww img "$wallpaper" \
          --transition-type "$SSJ_TRANSITION_TYPE" \
          --transition-duration "$SSJ_TRANSITION_DURATION" \
          &> /dev/null &

        # Wait for transition to complete
        sleep 0.5
      fi
      ;;

    hyprpaper)
      if command -v hyprpaper &> /dev/null; then
        # Kill old mpvpaper instances that might be running
        pkill -f "mpvpaper" &> /dev/null

        hyprctl hyprpaper preload "$wallpaper" &> /dev/null
        hyprctl hyprpaper wallpaper ",$wallpaper" &> /dev/null
      fi
      ;;
  esac
}

ssj_change_wallpaper() {
  local static_wallpaper=$1
  local animated_wallpaper=$2

  if [[ "$SSJ_ENABLE_WALLPAPER" != "true" ]]; then
    return
  fi

  local mode=$(ssj_get_wallpaper_mode)

  case "$mode" in
    animated)
      # Try animated only
      if ! ssj_change_wallpaper_mpvpaper "$animated_wallpaper"; then
        # If animated fails, silently skip (user requested animated explicitly)
        :
      fi
      ;;

    auto)
      # Try animated first, fallback to static
      if ! ssj_change_wallpaper_mpvpaper "$animated_wallpaper"; then
        ssj_change_wallpaper_static "$static_wallpaper"
      fi
      ;;

    static|*)
      # Static only
      ssj_change_wallpaper_static "$static_wallpaper"
      ;;
  esac
}

# ============================================================
# Sound Functions
# ============================================================

ssj_play_sound() {
  local sound_file=$1

  if [[ "$SSJ_ENABLE_SOUND" != "true" ]]; then
    return
  fi

  if [[ ! -f "$sound_file" ]]; then
    # Silently skip if sound doesn't exist
    return
  fi

  case "$SSJ_AUDIO_PLAYER" in
    mpv)
      if command -v mpv &> /dev/null; then
        # Play sound once at MAXIMUM volume (150 for extra power!)
        # mpv volume can go above 100 for amplification
        mpv --no-terminal --volume=150 --audio-normalize-downmix=yes "$sound_file" &> /dev/null &
      fi
      ;;
    paplay)
      if command -v paplay &> /dev/null; then
        # paplay at maximum volume (65536 = 100%)
        paplay --volume=65536 "$sound_file" &> /dev/null &
      fi
      ;;
    ffplay)
      if command -v ffplay &> /dev/null; then
        # ffplay at maximum volume
        ffplay -nodisp -autoexit -volume 100 "$sound_file" &> /dev/null &
      fi
      ;;
  esac
}

# ============================================================
# Transformation Sequence
# ============================================================

ssj_transformation_sequence() {
  local level=$1
  local ascii_file=$2
  local static_wallpaper=$3
  local animated_wallpaper=$4parameter
  local sound=$5
  local color=$6
  local level_name=$7

  # Set terminal title
  ssj_set_terminal_title "⚡ Transforming to $level_name ⚡"

  # Clear screen if enabled
  if [[ "$SSJ_CLEAR_SCREEN" == "true" ]]; then
    clear
  fi

  # Energy aura at start
  ssj_energy_aura "$color" 2

  # Start transformation
  echo ""
  ssj_print_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$color"
  ssj_color_pulse "       TRANSFORMATION SEQUENCE" "$color" "white"
  ssj_print_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$color"
  echo ""

  # Play sound immediately with MAXIMUM VOLUME!
  ssj_play_sound "$sound"

  # Change wallpaper in background (static and/or animated)
  ssj_change_wallpaper "$static_wallpaper" "$animated_wallpaper"

  # Stage 1: Energy gathering (1s)
  sleep 0.2
  ssj_color_pulse "  ⚡ Gathering energy..." "yellow" "white"
  sleep 0.5

  # Color wave during energy gathering
  ssj_color_wave "horizontal"

  # Animate terminal background color change
  ssj_animate_terminal_bg "$level"

  # Stage 2: Power rising (1.5s)
  if [[ "$SSJ_ANIMATION_DURATION" -ge 2 ]]; then
    echo ""
    ssj_loading_animation 1.5 "$color"
  fi

  # Stage 3: Energy burst (0.6-1.2s depending on level)
  echo ""
  ssj_energy_burst "$level" "$color"

  # Opacity pulse during energy burst
  ssj_opacity_pulse 2

  # Lightning and glitch before climax
  ssj_lightning_flash 3
  ssj_character_glitch 8

  # Stage 4: ASCII art reveal (0.5s + display time)
  echo ""
  ssj_show_ascii_art "$ascii_file" "$color"

  # Stage 5: Completion message
  echo ""
  ssj_print_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$color"
  ssj_color_pulse "   ⚡ TRANSFORMATION COMPLETE! ⚡" "$color" "white"
  ssj_print_color "        $level_name" "$color"
  ssj_print_color "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$color"
  echo ""

  # Update terminal title
  ssj_set_terminal_title "⚡ $level_name ⚡"

  # Brief pause before returning to prompt
  sleep 0.5
}

# ============================================================
# ULTRA INSTINCT Transformation Sequence (8 SECONDS OF EPIC!)
# ============================================================

ssj_ui_transformation_sequence() {
  local ascii_file=$UI_ASCII
  local static_wallpaper=$UI_WALLPAPER
  local animated_wallpaper=$UI_WALLPAPER_ANIMATED  # NEW
  local sound=$UI_SOUND

  # Set terminal title
  ssj_set_terminal_title "⟨ AWAKENING ULTRA INSTINCT ⟩"

  # Clear screen if enabled
  if [[ "$SSJ_CLEAR_SCREEN" == "true" ]]; then
    clear
  fi

  # WALLPAPER CHANGES AT START (SYNCED!) - static and/or animated
  ssj_change_wallpaper "$static_wallpaper" "$animated_wallpaper"

  # SOUND AT MAXIMUM VOLUME!
  ssj_play_sound "$sound"

  # Hide cursor for dramatic effect
  tput civis 2>/dev/null

  echo ""
  print -P "%F{255}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%f"
  ssj_color_pulse "        AWAKENING ULTRA INSTINCT" "255" "51"
  print -P "%F{255}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%f"
  echo ""

  # Stage 1: PEAK TRANSFORMATION - IMMEDIATE MAXIMUM POWER! (3.5s)
  ssj_ui_peak_transformation

  # Animate terminal background to silver/white for Ultra Instinct
  ssj_animate_terminal_bg "ui"

  # Stage 2: Awakening (1.5s)
  sleep 0.3
  print -P "%F{255}A u t o n o m o u s . . .%f"
  sleep 0.4
  print -P "%F{51}  U l t r a . . .%f"
  sleep 0.4
  print -P "%F{213}    I n s t i n c t . . .%f"
  sleep 0.4

  # Stage 3: Particle Explosion (1s)
  ssj_particle_explosion

  # Stage 4: Power Level Counter (1.5s)
  ssj_power_counter

  # Stage 5: Shockwave Animation (1s)
  ssj_shockwave_animation

  # Stage 6: COLOR INVERSION FLASH! (0.8s)
  ssj_color_invert

  # Stage 7: Screen Shake! (0.4s)
  ssj_screen_shake

  # Stage 8: Matrix Rain! (0.5s)
  ssj_matrix_rain

  # Stage 9: ASCII Art Reveal (1s)
  echo ""
  ssj_show_ascii_art "$ascii_file" "255"

  # Final Message
  echo ""
  print -P "%F{255}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%f"
  ssj_color_pulse "    ⟨ TRANSFORMATION COMPLETE ⟩" "255" "51"
  print -P "%F{51}        MASTERED ULTRA INSTINCT%f"
  print -P "%F{213}        Power Level: ∞ IMMEASURABLE%f"
  print -P "%F{255}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%f"
  echo ""

  # Show cursor again
  tput cnorm 2>/dev/null

  # Update terminal title
  ssj_set_terminal_title "⟨ ULTRA INSTINCT MASTERED ⟩"

  # Brief pause before returning to prompt
  sleep 0.5
}

# ============================================================
# Main SSJ Command
# ============================================================

ssj() {
  # Load configuration
  ssj_load_config

  # Parse command-line arguments for wallpaper mode overrides
  ssj_parse_args "$@"

  # Extract the action (remove flags like --animated/--static)
  local action=""
  for arg in "$@"; do
    if [[ "$arg" != --* ]]; then
      action="$arg"
      break
    fi
  done

  local current_mode=1

  # Read current mode
  if [[ -f "$SSJ_STATE_FILE" ]]; then
    current_mode=$(cat "$SSJ_STATE_FILE" 2>/dev/null)
    if [[ ! "$current_mode" =~ ^[1-4]$ ]]; then
      current_mode=1
    fi
  fi

  case "$action" in
    1)
      echo "$action" > "$SSJ_STATE_FILE"
      if [[ "$SSJ_ENABLE_ANIMATIONS" == "true" ]]; then
        ssj_transformation_sequence 1 "$SSJ1_ASCII" "$SSJ1_WALLPAPER" "$SSJ1_WALLPAPER_ANIMATED" "$SSJ1_SOUND" "yellow" "SUPER SAIYAN"
      else
        print -P "%F{yellow}⚡ Transforming to Super Saiyan... ⚡%f"
        ssj_change_wallpaper "$SSJ1_WALLPAPER" "$SSJ1_WALLPAPER_ANIMATED"
        ssj_play_sound "$SSJ1_SOUND"
        ssj_set_terminal_title "⚡ SUPER SAIYAN ⚡"
      fi
      zle && zle reset-prompt
      ;;

    2)
      echo "$action" > "$SSJ_STATE_FILE"
      if [[ "$SSJ_ENABLE_ANIMATIONS" == "true" ]]; then
        ssj_transformation_sequence 2 "$SSJ2_ASCII" "$SSJ2_WALLPAPER" "$SSJ2_WALLPAPER_ANIMATED" "$SSJ2_SOUND" "cyan" "SUPER SAIYAN 2"
      else
        print -P "%F{cyan}⚡⚡ Transforming to Super Saiyan 2... ⚡⚡%f"
        ssj_change_wallpaper "$SSJ2_WALLPAPER" "$SSJ2_WALLPAPER_ANIMATED"
        ssj_play_sound "$SSJ2_SOUND"
        ssj_set_terminal_title "⚡⚡ SUPER SAIYAN 2 ⚡⚡"
      fi
      zle && zle reset-prompt
      ;;

    3)
      echo "$action" > "$SSJ_STATE_FILE"
      if [[ "$SSJ_ENABLE_ANIMATIONS" == "true" ]]; then
        ssj_transformation_sequence 3 "$SSJ3_ASCII" "$SSJ3_WALLPAPER" "$SSJ3_WALLPAPER_ANIMATED" "$SSJ3_SOUND" "201" "SUPER SAIYAN 3"
      else
        print -P "%F{201}⚡⚡⚡ Transforming to Super Saiyan 3... ⚡⚡⚡%f"
        ssj_change_wallpaper "$SSJ3_WALLPAPER" "$SSJ3_WALLPAPER_ANIMATED"
        ssj_play_sound "$SSJ3_SOUND"
        ssj_set_terminal_title "⚡⚡⚡ SUPER SAIYAN 3 ⚡⚡⚡"
      fi
      zle && zle reset-prompt
      ;;

    4|ui|ultimate|mastered)
      # ULTRA INSTINCT - THE ULTIMATE FORM!
      echo "4" > "$SSJ_STATE_FILE"
      if [[ "$SSJ_ENABLE_ANIMATIONS" == "true" && "$SSJ_UI_ENABLED" == "true" ]]; then
        ssj_ui_transformation_sequence
      else
        print -P "%F{255}⟨ Transforming to ULTRA INSTINCT... ⟩%f"
        ssj_change_wallpaper "$UI_WALLPAPER" "$UI_WALLPAPER_ANIMATED"
        ssj_play_sound "$UI_SOUND"
        ssj_set_terminal_title "⟨ ULTRA INSTINCT MASTERED ⟩"
      fi
      zle && zle reset-prompt
      ;;

    up)
      local new_mode=$((current_mode + 1))
      if [[ $new_mode -gt 4 ]]; then
        new_mode=4
        print -P "%F{255}Already at ULTRA INSTINCT! (Maximum Power!)%f"
      else
        ssj $new_mode
      fi
      ;;

    down)
      local new_mode=$((current_mode - 1))
      if [[ $new_mode -lt 1 ]]; then
        new_mode=1
        print -P "%F{yellow}Already at base form! (SSJ1)%f"
      else
        ssj $new_mode
      fi
      ;;

    status)
      local level_name=""
      case "$current_mode" in
        1) level_name="Super Saiyan (SSJ1)" ;;
        2) level_name="Super Saiyan 2 (SSJ2)" ;;
        3) level_name="Super Saiyan 3 (SSJ3)" ;;
        4) level_name="⟨ ULTRA INSTINCT MASTERED ⟩" ;;
      esac
      print -P "%F{yellow}Current transformation:%f %F{255}$level_name%f"
      ;;

    config)
      # Edit configuration
      if [[ -f "$SSJ_CONFIG_FILE" ]]; then
        ${EDITOR:-nano} "$SSJ_CONFIG_FILE"
      else
        print -P "%F{red}Config file not found:%f $SSJ_CONFIG_FILE"
        print -P "Run the installation script to create it."
      fi
      ;;

    help|--help|-h)
      cat <<EOF
Super Saiyan Prompt - ULTRA INSTINCT EDITION

USAGE:
  ssj <command>

COMMANDS:
  1, 2, 3, 4        Transform to specific level with EPIC animation
  ui, ultimate      Transform to ULTRA INSTINCT (same as 4)
  mastered          Ultra Instinct Mastered
  up                Level up one transformation
  down              Power down one transformation
  status            Show current transformation level
  config            Edit configuration file
  help              Show this help message

EXAMPLES:
  ssj 1        # Transform to Super Saiyan
  ssj 2        # Transform to Super Saiyan 2
  ssj 3        # Transform to Super Saiyan 3
  ssj 4        # Transform to ULTRA INSTINCT! (8 seconds of INSANITY!)
  ssj ui       # Same as ssj 4
  ssj up       # Power up to next level
  ssj config   # Customize settings

FEATURES:
  ⚡ Cinematic transformation animations (4-8 seconds!)
  ⚡ Wallpaper changes (swww/hyprpaper) - FIXED!
  ⚡ Transformation sound effects at MAX VOLUME!
  ⚡ Screen flash effects
  ⚡ Terminal title changes
  ⚡ ASCII art displays
  ⚡ Color pulsing effects
  ⚡ ULTRA INSTINCT EXCLUSIVE EFFECTS:
    ∴ Shockwave animation
    ∴ Particle explosion
    ∴ Matrix rain effect
    ∴ Screen shake
    ∴ Color inversion flashes
    ∴ Animated power counter
  ⚡ Fully customizable via config file

CONFIGURATION:
  Config file: $SSJ_CONFIG_FILE
  Edit with: ssj config

For more info, see README.md
EOF
      ;;

    "")
      ssj status
      ;;

    *)
      print -P "%F{red}Invalid command:%f $action"
      print -P "Run '%F{cyan}ssj help%f' for usage information"
      return 1
      ;;
  esac
}

# ============================================================
# Initialize
# ============================================================

# Create state file if it doesn't exist
if [[ ! -f "$SSJ_STATE_FILE" ]]; then
  echo "1" > "$SSJ_STATE_FILE"
fi

# Create config directory if it doesn't exist
if [[ ! -d "$SSJ_CONFIG_DIR" ]]; then
  mkdir -p "$SSJ_CONFIG_DIR"/{wallpapers,sounds,ascii-art}
fi
