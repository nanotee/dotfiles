alias exa="exa --icons"
alias ls="exa"
alias l="ls -1a"
alias ll="ls -lh"
alias la="ll -a"
alias tree="exa --tree"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias mkdirs="mkdir -p"
mkcd() { mkdir -p "$@" && cd "$@"; }

alias g=git

alias nvimm='nvim --cmd "let minimal_config=v:true"'
alias vim="VIM=$XDG_CONFIG_HOME/vim vim"

detach() { "$@" &>/dev/null &! }

define() { curl "dict://dict.org/d:$1"; }

alias path='echo $PATH | tr ":" "\n" | nl'
