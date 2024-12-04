if status is-interactive
	# Commands to run in interactive sessions can go here
	starship init fish | source
end

function fish_user_key_bindings
	fish_vi_key_bindings
end

set fish_cursor_visual block
bind \cm 'echo "test"'

bind \ci nextd

