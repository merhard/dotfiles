alias b='bundle install'
alias bu='bundle update --conservative'

alias buo='brew update && brew outdated'
alias buc='brew upgrade && brew cleanup -s'

alias ets='ember test --server --no-launch'

(( $+commands[hub] )) && alias git=hub


alias nom='rm -rf dist node_modules tmp; npm i'

alias trt='touch tmp/restart.txt'

alias v2g='video-to-gif'
