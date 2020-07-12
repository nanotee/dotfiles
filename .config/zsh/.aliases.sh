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

alias G=git

alias nvimm='nvim --cmd "let minimal_config=v:true"'
