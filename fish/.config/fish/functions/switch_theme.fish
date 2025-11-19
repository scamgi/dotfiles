#!/usr/bin/env fish

function toggle_theme --argument-names target_theme
    # Default to latte if no argument provided
    if test -z "$target_theme"
        set target_theme latte
    end

    # Set flavor variables based on target
    if test "$target_theme" = latte
        set origin_theme mocha
        set origin_cap Mocha
        set target_cap Latte
        set zed_mode light
    else if test "$target_theme" = mocha
        set origin_theme latte
        set origin_cap Latte
        set target_cap Mocha
        set zed_mode dark
    else
        echo "Error: Theme must be 'latte' or 'mocha'"
        return 1
    end

    echo "󰸉 Switching theme from $origin_cap to $target_cap..."

    # --- Paths to config files ---
    set alacritty_conf ~/.config/alacritty/alacritty.toml
    set starship_conf ~/.config/starship.toml
    set tmux_conf ~/.tmux.conf
    set nvim_conf ~/.config/nvim/lua/plugins/colorscheme.lua
    set bat_conf ~/.config/bat/config

    # --- OS Detection for sed ---
    # macOS requires an empty string after -i, Linux does not
    if test (uname) = Darwin
        alias sed_cmd "sed -i ''"
    else
        alias sed_cmd "sed -i"
    end

    # 1. Alacritty
    # Changes "catppuccin-mocha.toml" to "catppuccin-latte.toml"
    if test -f $alacritty_conf
        sed_cmd "s/catppuccin-$origin_theme/catppuccin-$target_theme/g" $alacritty_conf
        echo "  ✔ Alacritty updated"
    end

    # 2. Starship
    # Changes "palette = 'catppuccin_mocha'" to "palette = 'catppuccin_latte'"
    if test -f $starship_conf
        sed_cmd "s/catppuccin_$origin_theme/catppuccin_$target_theme/g" $starship_conf
        echo "  ✔ Starship updated"
    end

    # 3. Neovim (LazyVim)
    # Changes "flavour = 'mocha'" to "flavour = 'latte'"
    if test -f $nvim_conf
        sed_cmd "s/flavour = \"$origin_theme\"/flavour = \"$target_theme\"/g" $nvim_conf
        echo "  ✔ Neovim updated"
    end

    # 4. Bat
    # Changes "--theme=\"Catppuccin Mocha\"" to "--theme=\"Catppuccin Latte\""
    if test -f $bat_conf
        sed_cmd "s/Catppuccin $origin_cap/Catppuccin $target_cap/g" $bat_conf
        echo "  ✔ Bat updated"
    end

    # 5. Tmux
    # Changes "@catppuccin_flavor 'mocha'" to "@catppuccin_flavor 'latte'"
    if test -f $tmux_conf
        sed_cmd "s/@catppuccin_flavor \"$origin_theme\"/@catppuccin_flavor \"$target_theme\"/g" $tmux_conf
        # Reload tmux if running
        if command -v tmux >/dev/null; and pgrep tmux >/dev/null
            tmux source $tmux_conf
            echo "  ✔ Tmux updated & reloaded"
        else
            echo "  ✔ Tmux updated (not running)"
        end
    end

    echo "Done! You may need to restart your shell instances."
end

# Run the function
toggle_theme $argv
