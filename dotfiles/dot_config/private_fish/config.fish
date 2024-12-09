if status is-interactive
end

fish_vi_key_bindings
starship init fish | source

set -a PATH /opt/nvim-linux64/bin
set -a PATH /usr/local/go/bin
set -a PATH ~/go/bin
set -a PATH ~/bin

source ~/.asdf/asdf.fish
set -gx EDITOR nvim
bind --erase \cN
bind --mode insert \cN 'nvim .'
bind --mode command \cN 'command nvim .'

# # bind -M insert \t complete-and-search
# bind -M insert \cq complete-and-search

bind --mode insert \cj 'prevd; commandline -f repaint'
bind --mode command \cj 'prevd; commandline -f repaint'
bind --mode insert \ck 'nextd; commandline -f repaint'
bind --mode command \ck 'nextd; commandline -f repaint'

bind --mode insert :q exit

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
