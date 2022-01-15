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

detach() { (nohup "$@" &>/dev/null &) }

alias path='echo $PATH | tr ":" "\n" | nl'
