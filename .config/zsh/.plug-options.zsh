leader='ù'

# Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# FZF tab
zstyle ':completion:*:descriptions' format '[%d]'

# lfcd
bindkey -s "${leader}f" 'lfcd\n'
