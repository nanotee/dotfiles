# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_if_exists() {
    [ -f "$1" ] && source "$1"
}

source <(antibody init)

# zsh-completions has to be added to fpath early or compinit won't take it into account
antibody bundle zsh-users/zsh-completions kind:fpath path:src

source_if_exists "$ASDF_DATA_DIR/asdf.sh"
fpath=($ASDF_DATA_DIR/completions $fpath)

source_if_exists "${ZDOTDIR:-$HOME}/.options.zsh"
source_if_exists "${ZDOTDIR:-$HOME}/.aliases.sh"

# Plugins
antibody bundle << EOF
romkatv/powerlevel10k
z-shell/fast-syntax-highlighting
Aloxaf/fzf-tab
troydm/exp kind:path
todotxt/todo.txt-cli kind:path
trapd00r/vidir kind:path path:bin
chubin/cheat.sh kind:path path:share
EOF
source_if_exists "${ZDOTDIR:-$HOME}/.plug-options.zsh"

eval "$(zoxide init zsh)"
source_if_exists "$XDG_CONFIG_HOME/lf/lf-icons"
autoload -Uz lfcd.sh && lfcd.sh
source_if_exists "/usr/share/fzf/key-bindings.zsh"
autoload -Uz _fzf && _fzf

# GPG
export GPG_TTY=$TTY

# Vim emulation
source_if_exists "${ZDOTDIR:-$HOME}/.vim.zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
