export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim --cmd 'let minimal_config=v:true | set laststatus=0' +Man!"
export BROWSER="firefox"
export OPENER="xdg-open"
export LESS=" -R "
export FZF_DEFAULT_COMMAND="fd --type f --follow --exclude .git"
export GTK_USE_PORTAL=1
export SUDO_ASKPASS="$HOME/.local/bin/gui-askpass"

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$NODENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$XDG_DATA_HOME/nimble/bin:$PATH"
export PATH="$XDG_DATA_HOME/luarocks/bin:$PATH"
