function set_theme --argument-names mode
    set ghostty_path ~/.config/ghostty/config
    set starship_path ~/.config/starship.toml

    if test -z "$mode"
        if grep -q Mocha $ghostty_path
            set mode light
        else
            set mode dark
        end
    end

    if test "$mode" = light
        echo "☕️ Switching to Catppuccin Latte..."

        # fish shell
        fish_config theme save "Catppuccin Latte"

        # ghostty
        set content (cat $ghostty_path)
        string replace -r 'theme = .*' 'theme = Catppuccin Latte' $content >$ghostty_path

        # starship
        set content (cat $starship_path)
        string replace -r "palette = .*" "palette = 'catppuccin_latte'" $content >$starship_path

    else
        echo "🌑 Switching to Catppuccin Mocha..."

        # fish shell
        fish_config theme save "Catppuccin Mocha"

        # ghostty
        set content (cat $ghostty_path)
        string replace -r 'theme = .*' 'theme = Catppuccin Mocha' $content >$ghostty_path

        # starship
        set content (cat $starship_path)
        string replace -r "palette = .*" "palette = 'catppuccin_mocha'" $content >$starship_path
    end
end
