# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# History Substring Search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# FZF tab
zstyle ':completion:*:descriptions' format '[%d]'
