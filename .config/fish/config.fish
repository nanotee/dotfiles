if not status is-interactive
    return
end

fish_vi_key_bindings
fzf --fish | source
zoxide init fish | source
