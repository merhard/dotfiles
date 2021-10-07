[[ -v ASDF_DIR ]] && fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
