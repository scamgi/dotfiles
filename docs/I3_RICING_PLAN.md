# I3 Rice Prompts & Specification

**Context for the AI:**
I am setting up a fresh development environment on **Ubuntu** using the **i3 Window Manager**. I already have a dotfiles repository (managed with **GNU Stow**) that handles my shell (Fish), editor (Neovim), and terminals (Ghostty/Alacritty).

I need you to act as a **Senior Linux Ricing Expert** to guide me step-by-step in setting up a beautiful, cohesive i3 environment that matches my existing "Catppuccin Mocha" theme.

## 1. Design System & Aesthetics
*   **Theme:** Catppuccin Mocha (Dark).
*   **Font:** "Liga SFMono Nerd Font" (already installed in my dotfiles).
*   **Cursor:** Catppuccin Mocha cursors.
*   **Wallpaper:** Need a mechanism to set a wallpaper (e.g., `feh` or `nitrogen`).
*   **Vibe:** Minimalist, flat, rounded corners, blur/transparency effects.

## 2. Technology Stack (The "Rice")
I want to use the following standard tools. Please generate installation scripts and configuration files for:
*   **WM:** `i3` (specifically `i3-gaps` functionality, though modern i3 has this built-in).
*   **Bar:** `polybar` (I want a floating bar style, not a full-width block).
*   **Launcher:** `rofi` (themed to match Catppuccin).
*   **Compositor:** `picom` (standard or a fork like `picom-pijulius` if needed for smooth animations and rounded corners).
*   **Notifications:** `dunst`.
*   **Lock Screen:** `i3lock-color` or `betterlockscreen`.
*   **GTK Theme:** `Lxappearance` to set GTK settings to Catppuccin.

## 3. Existing Dotfiles Structure
My repository is structured for **GNU Stow**.
*   Root folder: `~/.dotfiles`
*   Package folder example: `~/.dotfiles/i3/.config/i3/config`
*   I expect you to provide file paths relative to `~/.dotfiles/` so I can stow them easily.

## 4. Specific Tasks for the AI

Please guide me through the following phases. **Do not output everything at once.** Let's do this step-by-step.

### Phase 1: Installation (Ubuntu)
Generate a bash script snippet to install all necessary dependencies on Ubuntu (`apt` + build essentials if needed).
*   Include: `i3`, `polybar`, `rofi`, `picom`, `dunst`, `feh`, `thunar` (file manager), `lxappearance`.
*   Ensure dependencies for building things from source are included if apt versions are too old.

### Phase 2: Directory Structure
Tell me exactly which folders to create in my `~/.dotfiles` repo to support `stow`.
*   Example: `mkdir -p i3/.config/i3`, `mkdir -p polybar/.config/polybar`, etc.

### Phase 3: The Configurations
Generate the config files with the **Catppuccin Mocha** color palette hardcoded or included.

1.  **i3 Config (`~/.dotfiles/i3/.config/i3/config`):**
    *   Use **Vim keys** (h,j,k,l) for focus navigation.
    *   Use `Mod+Enter` for Terminal (use `ghostty` or `alacritty` based on what's available).
    *   Use `Mod+d` for `rofi`.
    *   Set gaps (inner 10px, outer 5px).
    *   Remove window title bars.
    *   Add autostart section (polybar, picom, feh, dunst).

2.  **Polybar (`~/.dotfiles/polybar/.config/polybar/config.ini`):**
    *   Modules: Workspaces (dots or numbers), CPU, RAM, Date, Audio, Power Menu.
    *   Colors: Catppuccin Mocha hex codes.
    *   Font: "Liga SFMono Nerd Font".

3.  **Rofi (`~/.dotfiles/rofi/.config/rofi/config.rasi`):**
    *   Mode: `drun` + `run`.
    *   Theme: Custom Catppuccin style (or point me to a `.rasi` file).

4.  **Picom (`~/.dotfiles/picom/.config/picom/picom.conf`):**
    *   Enable rounded corners (radius: 12).
    *   Enable basic transparency for inactive windows (opacity 0.9).
    *   Enable shadows.

5.  **Dunst (`~/.dotfiles/dunst/.config/dunst/dunstrc`):**
    *   Match the border and background colors.

### Phase 4: Integration
*   Instructions on how to run `stow` for these new packages.
*   Instructions on how to reload i3 to see changes.

---

**Please start by confirming you understand the plan and proceed with "Phase 1: Installation".**
