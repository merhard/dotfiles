[[ -v HISTFILE ]] || HISTFILE=$HOME/.zsh_history

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# Enable Elixir/Erlang shell history
[[ -v IEX_HISTFILE ]] || IEX_HISTFILE=$HOME/.iex_history
ERL_AFLAGS="-kernel shell_history enabled"
ERL_AFLAGS="$ERL_AFLAGS -kernel shell_history_file_bytes 1024000"
ERL_AFLAGS="$ERL_AFLAGS -kernel shell_history_path '\"$IEX_HISTFILE\"'"
export ERL_AFLAGS
