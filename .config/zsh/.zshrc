# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -s "${ZDOTDIR:-$HOME}/.options.zsh" ] && source "${ZDOTDIR:-$HOME}/.options.zsh"
[ -s "${ZDOTDIR:-$HOME}/.aliases.sh" ] && source "${ZDOTDIR:-$HOME}/.aliases.sh"

# Plugins
source <(antibody init)
antibody bundle < "$ZDOTDIR/zsh_plugins.txt"
[ -s "${ZDOTDIR:-$HOME}/.plug-options.zsh" ] && source "${ZDOTDIR:-$HOME}/.plug-options.zsh"

eval "$(zoxide init zsh)"
[ -s "$XDG_CONFIG_HOME/lf/lf-icons" ] && source "$XDG_CONFIG_HOME/lf/lf-icons"
[ -s "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"
[ -s "/usr/share/zsh/site-functions/_fzf" ] && source "/usr/share/zsh/site-functions/_fzf"

# Environment
eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# GPG
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# Vim emulation
[ -s "${ZDOTDIR:-$HOME}/.vim.zsh" ] && source "${ZDOTDIR:-$HOME}/.vim.zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
