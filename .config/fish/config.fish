if status is-interactive
    fish_vi_key_bindings
    fzf --fish | source
    zoxide init fish | source
end
