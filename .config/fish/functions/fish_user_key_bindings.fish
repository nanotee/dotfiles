function fish_user_key_bindings
    if test "$__fish_active_key_bindings" = "fish_vi_key_bindings"
        bind --mode insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
    end
end
