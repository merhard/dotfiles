autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

[[ -d "$HOME/.asdf" ]] && source $HOME/.asdf/completions/asdf.bash
