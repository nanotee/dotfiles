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

alias nvimm='nvim --cmd "let minimal_config=v:true"'

detach() { (nohup "$@" &>/dev/null &) }

define() { curl "dict://dict.org/d:$1"; }

alias path='echo $PATH | tr ":" "\n" | nl'

alias mitmproxy='mitmproxy --set confdir="$XDG_CONFIG_HOME/mitmproxy"'
alias mitmweb='mitmweb --set confdir="$XDG_CONFIG_HOME/mitmproxy"'
