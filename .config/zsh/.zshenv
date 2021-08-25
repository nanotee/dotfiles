export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim -u NORC --noplugin --cmd 'runtime! plugin/man.vim' +Man!"
export BROWSER="firefox"
export OPENER="xdg-open"
export LESS=" -R "
export FZF_DEFAULT_COMMAND="fd --type f --follow --exclude .git"
# colors taken from dracula.vim
export FZF_DEFAULT_OPTS='--color=bg+:#282A36,bg:#282A36,spinner:#FF79C6,hl:#50FA7B,fg:#F8F8F2,header:#6272A4,info:#BD93F9,pointer:#FF79C6,marker:#FF79C6,fg+:#F8F8F2,prompt:#50FA7B,hl+:#FFB86C'
export GTK_USE_PORTAL=1
export SUDO_ASKPASS="$XDG_BIN_HOME/gui-askpass"

# env
export PATH="$NODENV_ROOT/bin:$PATH"
export PATH="$NODENV_ROOT/shims:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"
export PATH="$PHPENV_ROOT/bin:$PATH"
export PATH="$PHPENV_ROOT/shims:$PATH"
export PATH="$XDG_DATA_HOME/nimble/bin:$PATH"
export PATH="$XDG_DATA_HOME/luarocks/bin:$PATH"
export PATH="/usr/lib/openjdk-11/bin:$PATH"
