# Put an alias to this file in /etc/profile.d

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Make as many applications XDG compliant as possible

## Configuration
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export HTML_TIDY="$XDG_CONFIG_HOME/tidy/tidyrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

## Data
export NODENV_ROOT="$XDG_DATA_HOME/nodenv"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export GEM_HOME="$XDG_DATA_HOME/gem"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export STARDICT_DATA_DIR="$XDG_DATA_HOME/stardict"

## Cache
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
