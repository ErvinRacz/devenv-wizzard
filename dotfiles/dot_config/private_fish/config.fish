if status is-interactive
end

fish_vi_key_bindings
starship init fish | source
set fish_cursor_visual block

set -a PATH /opt/nvim-linux64/bin
set -a PATH /usr/local/go/bin

source ~/.asdf/asdf.fish

set -gx EDITOR nvim
bind --erase \cN
bind --mode insert \cN 'nvim .'
bind --mode command \cN 'nvim .'



bind --mode insert -m insert \co 'prevd; commandline -f repaint'
bind --mode command -m insert \co 'prevd; commandline -f repaint'
bind --mode insert -m insert \ci 'nextd; commandline -f repaint'
bind --mode command -m insert \ci 'nextd; commandline -f repaint'


bind --mode insert :q exit

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
