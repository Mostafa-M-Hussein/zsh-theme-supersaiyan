# Super Saiyan Oh-My-Zsh Theme System - Implementation Plan

## Overview
Build a Dragon Ball-inspired prompt system with three transformation levels (SSJ1→SSJ2→SSJ3) that can be switched dynamically with smooth transitions.

## Architecture Decision

### Two Options Considered

**Option 1: Three Separate Theme Files**
- Separate `.zsh-theme` files for each level
- Switcher changes `ZSH_THEME` variable
- ❌ Requires shell reload, code duplication, no smooth transitions

**Option 2: Single Dynamic Theme (RECOMMENDED)**
- One theme file that reads mode from state file
- Instant switching by updating state + refreshing prompt
- ✅ Better UX, DRY code, supports animations, shared logic

## Recommended Approach: **Option 2 - Single Dynamic Theme**

### Why This Approach?
1. **Instant switching** - no shell reload needed
2. **Transformation animations** - can show "powering up" messages
3. **Maintainable** - shared git/directory/exit code logic
4. **Better UX** - seamless transitions between levels
5. **State persistence** - survives shell restarts

---

## Implementation Plan

### File Structure

```
~/.oh-my-zsh/custom/
├── themes/
│   └── supersaiyan.zsh-theme          # Main theme file
└── plugins/
    └── ssj/
        ├── ssj.plugin.zsh             # Plugin entry point
        └── _ssj                       # Tab completion

~/.ssj_prompt_state                     # Persisted mode (1, 2, or 3)
```

### Component Breakdown

#### 1. Theme File: `supersaiyan.zsh-theme`

**Responsibilities:**
- Read current mode from `~/.ssj_prompt_state`
- Render appropriate prompt based on mode
- Shared helper functions for git status, directory, exit code

**Visual Design:**

**SSJ1 (Single-line, yellow/gold):**
```
[~/project] master ✓ ❯
```
- Colors: Yellow directory, green git branch, white separator
- Symbol: Single ❯
- Clean and energetic

**SSJ2 (Single-line, electric blue accents):**
```
[~/project] master ✓ ⚡❯
```
- Colors: Bright yellow directory, cyan git branch, electric blue accents
- Symbol: ⚡❯ (lightning + arrow)
- More intense, sharper visual feel

**SSJ3 (Multi-line, gold/long hair aesthetic):**
```
╭─⚡⚡⚡ [~/project] master ✓ ⚡⚡⚡
╰─❯❯❯
```
- Colors: Intense gold/orange directory, bright cyan git, red error indicators
- Symbol: Triple ❯❯❯
- Box drawing characters for multi-line layout
- Maximum visual impact

**Key Functions:**
- `ssj_get_mode()` - Read from state file, default to 1
- `ssj_git_prompt()` - Fast git status (branch + dirty/clean)
- `ssj_dir_prompt()` - Current directory (shortened if needed)
- `ssj_exit_code()` - Red indicator if last command failed
- `ssj_render_prompt()` - Main function that switches on mode

**Performance:**
- Git status cached per prompt render
- No expensive operations in prompt function
- Async git status updates (optional enhancement)

#### 2. Plugin: `ssj.plugin.zsh`

**Responsibilities:**
- Provide `ssj` command for switching modes
- Handle state file persistence
- Show transformation animations
- Refresh prompt after switch

**Commands:**
```bash
ssj 1          # Transform to SSJ1
ssj 2          # Transform to SSJ2
ssj 3          # Transform to SSJ3
ssj up         # Level up (1→2→3, caps at 3)
ssj down       # Power down (3→2→1, floor at 1)
ssj status     # Show current level
```

**Transformation Animation:**
```
$ ssj 2
⚡ Transforming to Super Saiyan 2... ⚡
[0.5 second delay]
[prompt re-renders as SSJ2]
```

**Implementation Details:**
- `ssj_transform()` - Main switching function
  - Validate input (1-3)
  - Write to `~/.ssj_prompt_state`
  - Show animation message
  - Sleep 0.5s
  - Refresh prompt with `zle reset-prompt`
- State file format: Single number (1, 2, or 3)
- Error handling: Invalid input shows usage

#### 3. Tab Completion: `_ssj`

**Provides completion for:**
- Numeric modes: `1`, `2`, `3`
- Named commands: `up`, `down`, `status`

**Implementation:**
```zsh
#compdef ssj
_ssj() {
  _arguments '1: :(1 2 3 up down status)'
}
```

---

## Color Scheme (Dragon Ball Inspired)

### SSJ1 - Golden Warrior
- Directory: `%F{yellow}` (golden yellow)
- Git branch: `%F{green}` (energy green)
- Symbols: `%F{white}` (clean white)
- Exit error: `%F{red}` (red for errors)

### SSJ2 - Electric Power
- Directory: `%F{226}` (bright yellow/gold)
- Git branch: `%F{cyan}` (electric blue)
- Lightning: `%F{blue}` (electric blue)
- Symbols: `%F{white}` (white)
- Exit error: `%F{red}` (red)

### SSJ3 - Maximum Power
- Directory: `%F{208}` (orange/gold for long hair)
- Git branch: `%F{51}` (bright cyan/electric)
- Lightning: `%F{201}` (magenta/energy)
- Box chars: `%F{226}` (bright gold)
- Symbols: `%F{white}` (white)
- Exit error: `%F{196}` (bright red)

---

## Installation Steps

### 1. Create Theme File
```bash
# Create supersaiyan.zsh-theme in custom themes directory
# (Implementation will be provided)
```

### 2. Create Plugin
```bash
# Create ssj plugin directory and files
mkdir -p ~/.oh-my-zsh/custom/plugins/ssj
# (Implementation files will be provided)
```

### 3. Update .zshrc
```bash
# Add to ~/.zshrc:
ZSH_THEME="supersaiyan"
plugins=(... ssj)  # Add ssj to plugins list
```

### 4. Initialize State File
```bash
# Create initial state file
echo "1" > ~/.ssj_prompt_state
```

### 5. Reload Shell
```bash
source ~/.zshrc
```

---

## Optional Enhancement: Powerlevel10k Version

Since you're open to installing powerlevel10k for better visualizations, we can provide an enhanced version that leverages p10k's features:

**Benefits:**
- Better icon support (Nerd Fonts)
- More colors and styling options
- Built-in async git status
- Segment-based architecture

**Trade-offs:**
- Additional dependency (powerlevel10k)
- Requires Nerd Font installation
- Slightly more complex setup

**Recommendation:** Start with standalone version, then optionally create p10k variant if you want richer visuals.

---

## Testing Plan

### Manual Tests:
1. Switch between all three modes with `ssj 1/2/3`
2. Use `ssj up/down` to cycle through levels
3. Test in git repo (clean, dirty, detached HEAD)
4. Test in non-git directory
5. Test with failed command (exit code display)
6. Restart terminal, verify mode persists
7. Test tab completion for ssj command

### Edge Cases:
- Invalid mode input (`ssj 4`, `ssj xyz`)
- Missing state file (should default to SSJ1)
- Corrupted state file (should default to SSJ1)
- `ssj up` at level 3 (should stay at 3)
- `ssj down` at level 1 (should stay at 1)

---

## Troubleshooting Guide

### Issue: Prompt doesn't change after `ssj` command
**Solution:** Ensure plugin is loaded in .zshrc, check that `zle reset-prompt` is working

### Issue: State doesn't persist across sessions
**Solution:** Verify `~/.ssj_prompt_state` file permissions and path

### Issue: Git status not showing
**Solution:** Check git command is in PATH, verify repo is valid

### Issue: Colors look wrong
**Solution:** Ensure terminal supports 256 colors (`echo $TERM`), use modern terminal

### Issue: Unicode symbols broken
**Solution:** Terminal may not support Unicode, fallback to ASCII symbols

---

## Future Enhancements (Optional)

1. **More transformation levels:** SSJ God, SSJ Blue, Ultra Instinct
2. **Animation effects:** More elaborate transformation sequences
3. **Sound effects:** Terminal bell on transformation (optional)
4. **Context-aware transformations:** Auto-level up in certain directories
5. **Performance metrics:** Show command execution time at SSJ3
6. **Integration with tmux:** Status bar shows SSJ level
7. **Nerd Font icons:** Better symbols with powerline/nerd fonts

---

## Summary

This implementation provides:
- ✅ Three distinct visual modes with progressive intensity
- ✅ Smooth switching with `ssj` command and animations
- ✅ State persistence across sessions
- ✅ Safe, portable, no dependencies (standalone version)
- ✅ Tab completion for commands
- ✅ Git branch/status, directory, exit code indicators
- ✅ Performant (no expensive prompt operations)
- ✅ Dragon Ball-inspired visual design
- ✅ Option 1 layout (SSJ3 multi-line, dramatic transformation)

The modular design allows for easy customization and future enhancements while maintaining simplicity and performance.
