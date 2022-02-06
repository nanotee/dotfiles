export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH="$XDG_BIN_HOME:$PATH"
export GTK_USE_PORTAL=1

# Make as many applications XDG compliant as possible

## Configuration
export ASDF_CONFIG_DIR="$XDG_CONFIG_HOME/asdf"
export ASDF_CONFIG_FILE="$ASDF_CONFIG_DIR/asdfrc"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="$ASDF_CONFIG_DIR/tool-versions"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ASDF_CONFIG_DIR/default-npm-packages"
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
export JDK_JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Dosgi.configuration.area=@user.home/.config/eclipse"
export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME/todo.txt/todo.cfg"
export ECLIPSE_HOME="$XDG_CONFIG_HOME/eclipse"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"

## Data
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export GEM_HOME="$XDG_DATA_HOME/gem"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export STARDICT_DATA_DIR="$XDG_DATA_HOME/stardict"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"

## State
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export MYSQL_HISTFILE="$XDG_STATE_HOME/mysql_history"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export PSQL_HISTORY="$XDG_STATE_HOME/pg/psql_history"

## Cache
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
