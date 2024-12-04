if status is-interactive
end

fish_vi_key_bindings
starship init fish | source
set fish_cursor_visual block
set -a PATH /opt/nvim-linux64/bin
set -gx EDITOR nvim
bind --erase \cN
bind --mode insert \cN 'nvim .'
bind --mode command \cN 'nvim .'


bind --mode insert :q exit
