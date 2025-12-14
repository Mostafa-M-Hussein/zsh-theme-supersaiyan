# ============================================================
# Super Saiyan Oh-My-Zsh Theme
# Dragon Ball Z Inspired Prompt System
# Supports FOUR transformation levels: SSJ1, SSJ2, SSJ3, ULTRA INSTINCT!
# ============================================================

# State file location
SSJ_STATE_FILE="${HOME}/.ssj_prompt_state"

# ============================================================
# Helper Functions
# ============================================================

# Get current SSJ mode from state file (default: 1)
ssj_get_mode() {
  if [[ -f "$SSJ_STATE_FILE" ]]; then
    local mode=$(cat "$SSJ_STATE_FILE" 2>/dev/null)
    # Validate mode is 1, 2, 3, or 4
    if [[ "$mode" =~ ^[1-4]$ ]]; then
      echo "$mode"
      return
    fi
  fi
  # Default to SSJ1
  echo "1"
}

# Get current directory (shortened if too long)
ssj_dir_prompt() {
  echo "%~"
}

# Git status prompt (fast, cached per prompt render)
ssj_git_prompt() {
  # Check if we're in a git repo
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    local git_status=$(git status --porcelain 2>/dev/null)

    if [[ -z "$git_status" ]]; then
      # Clean repo
      echo "$branch ✓"
    else
      # Dirty repo
      echo "$branch ✗"
    fi
  fi
}

# Exit code indicator (shows ✗ if last command failed)
ssj_exit_code() {
  echo "%(?..[%F{red}✗%f] )"
}

# ============================================================
# SSJ1 - Golden Warrior (Single-line, Clean)
# ============================================================
ssj1_prompt() {
  local dir_prompt=$(ssj_dir_prompt)
  local git_prompt=$(ssj_git_prompt)
  local exit_code=$(ssj_exit_code)

  # Build prompt
  local prompt_parts=""
  prompt_parts+="%F{yellow}[${dir_prompt}]%f"

  if [[ -n "$git_prompt" ]]; then
    prompt_parts+=" %F{green}${git_prompt}%f"
  fi

  prompt_parts+=" ${exit_code}%F{white}❯%f "

  echo "$prompt_parts"
}

# ============================================================
# SSJ2 - Electric Power (Single-line, Intense)
# ============================================================
ssj2_prompt() {
  local dir_prompt=$(ssj_dir_prompt)
  local git_prompt=$(ssj_git_prompt)
  local exit_code=$(ssj_exit_code)

  # Build prompt with electric theme
  local prompt_parts=""
  prompt_parts+="%F{226}[${dir_prompt}]%f"

  if [[ -n "$git_prompt" ]]; then
    prompt_parts+=" %F{cyan}${git_prompt}%f"
  fi

  prompt_parts+=" ${exit_code}%F{blue}⚡%f%F{white}❯%f "

  echo "$prompt_parts"
}

# ============================================================
# SSJ3 - Maximum Power (Multi-line, Dramatic)
# ============================================================
ssj3_prompt() {
  local dir_prompt=$(ssj_dir_prompt)
  local git_prompt=$(ssj_git_prompt)
  local exit_code=$(ssj_exit_code)

  # Build multi-line prompt
  local line1=""
  line1+="%F{226}╭─%f"
  line1+="%F{201}⚡⚡⚡%f "
  line1+="%F{208}[${dir_prompt}]%f"

  if [[ -n "$git_prompt" ]]; then
    line1+=" %F{51}${git_prompt}%f"
  fi

  line1+=" %F{201}⚡⚡⚡%f"

  local line2=""
  line2+="%F{226}╰─%f"
  line2+="${exit_code}"
  line2+="%F{white}❯❯❯%f "

  echo "${line1}\n${line2}"
}

# ============================================================
# ULTRA INSTINCT - Autonomous Power (Multi-line, Bordered)
# ============================================================
ssj4_prompt() {
  local dir_prompt=$(ssj_dir_prompt)
  local git_prompt=$(ssj_git_prompt)
  local exit_code=$(ssj_exit_code)

  # Build Ultra Instinct bordered prompt
  local line1=""
  line1+="╔═══⟨ %F{255}ULTRA INSTINCT%f ⟩═══╗"

  local line2=""
  line2+="║ %F{51}${dir_prompt}%f"

  if [[ -n "$git_prompt" ]]; then
    line2+=" • %F{213}${git_prompt}%f"
  fi

  line2+=" ║"

  local line3=""
  line3+="╚═══════════════════════════╝"

  local line4=""
  line4+="${exit_code}%F{255}▸▸▸%f "

  echo "%F{255}${line1}%f\n%F{255}${line2}%f\n%F{255}${line3}%f\n${line4}"
}

# ============================================================
# Main Prompt Renderer
# ============================================================
ssj_render_prompt() {
  local mode=$(ssj_get_mode)

  case "$mode" in
    1)
      ssj1_prompt
      ;;
    2)
      ssj2_prompt
      ;;
    3)
      ssj3_prompt
      ;;
    4)
      ssj4_prompt
      ;;
    *)
      # Fallback to SSJ1
      ssj1_prompt
      ;;
  esac
}

# ============================================================
# Set Prompts
# ============================================================

# Primary prompt (left side)
PROMPT='$(ssj_render_prompt)'

# Right prompt (optional - can show time or other info)
# RPROMPT='%F{8}%*%f'

# Continuation prompt (for multi-line commands)
PROMPT2='%F{yellow}❯%f '

# Selection prompt
PROMPT3='%F{yellow}?%f '

# Execution trace prompt
PROMPT4='%F{yellow}+%f '
