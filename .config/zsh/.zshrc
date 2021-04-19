# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_if_exists() {
    [ -f "$1" ] && source "$1"
}

source_if_exists "${ZDOTDIR:-$HOME}/.options.zsh"
source_if_exists "${ZDOTDIR:-$HOME}/.aliases.sh"

# Plugins
source <(antibody init)
antibody bundle < "$ZDOTDIR/zsh_plugins.txt"
source_if_exists "${ZDOTDIR:-$HOME}/.plug-options.zsh"

eval "$(zoxide init zsh)"
source_if_exists "$XDG_CONFIG_HOME/lf/lf-icons"
source_if_exists "$XDG_CONFIG_HOME/lf/lfcd.sh"
source_if_exists "/usr/share/fzf/key-bindings.zsh"
source_if_exists "/usr/share/zsh/site-functions/_fzf"

# *env completions
source_if_exists "$NODENV_ROOT/completions/nodenv.zsh"
source_if_exists "$PYENV_ROOT/completions/pyenv.zsh"
source_if_exists "$PHPENV_ROOT/completions/phpenv.zsh"

# GPG
export GPG_TTY=$TTY

# Vim emulation
source_if_exists "${ZDOTDIR:-$HOME}/.vim.zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
