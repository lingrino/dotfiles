#!/usr/bin/env fish

# source interactive configs
for file in ~/.config/fish/interactive.d/*.fish
    source $file
end

# init starship prompt
starship init fish | source
