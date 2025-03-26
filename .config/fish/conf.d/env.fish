set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_BIN_HOME "$HOME/.local/bin"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx WGETRC "$XDG_CONFIG_HOME/wgetrc"
set -gx HTML_TIDY "$XDG_CONFIG_HOME/tidy/tidyrc"
set -gx PGPASSFILE "$XDG_CONFIG_HOME/pg/pgpass"
set -gx PGSERVICEFILE "$XDG_CONFIG_HOME/pg/pg_service.conf"
set -gx NODE_REPL_HISTORY "$XDG_STATE_HOME/node_repl_history"
set -gx MYSQL_HISTFILE "$XDG_STATE_HOME/mysql_history"
set -gx SQLITE_HISTORY "$XDG_STATE_HOME/sqlite_history"
set -gx LESSHISTFILE "$XDG_STATE_HOME/less/history"
set -gx PSQL_HISTORY "$XDG_STATE_HOME/pg/psql_history"
set -gx PYTHON_HISTORY "$XDG_STATE_HOME/python/history"
set -gx PYTHONCACHEPREFIX "$XDG_CACHE_HOME/python"
set -gx PYTHONUSERBASE "$XDG_DATA_HOME/python"
set -gx DENO_INSTALL_ROOT "$XDG_DATA_HOME/deno"

set -gx PATH "/var/lib/flatpak/exports/bin" $PATH
set -gx PATH "/usr/lib/flatpak-xdg-utils" $PATH
set -gx PATH "$XDG_DATA_HOME/npm/bin" $PATH
set -gx PATH "$XDG_DATA_HOME/deno/bin" $PATH
set -gx PATH "$XDG_BIN_HOME" $PATH

set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx MANPAGER "nvim -u NORC --noplugin --cmd 'runtime! plugin/man.lua' +'color dracula' +'set termguicolors' +Man!"
set -gx OPENER "xdg-open"
set -gx LESS " -R "
set -gx FZF_DEFAULT_COMMAND "fd --type f --follow"
set -gx FZF_DEFAULT_OPTS "--color=bg+:#282A36,bg:#282A36,spinner:#FF79C6,hl:#50FA7B,fg:#F8F8F2,header:#6272A4,info:#BD93F9,pointer:#FF79C6,marker:#FF79C6,fg+:#F8F8F2,prompt:#50FA7B,hl+:#FFB86C"
set -gx SUDO_AKSPASS "$XDG_BIN_HOME/sudo-askpass"
