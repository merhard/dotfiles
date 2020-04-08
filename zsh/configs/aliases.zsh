alias b='bundle install'
alias bu='bundle update --conservative'

alias buo='brew update && brew outdated'
alias buc='brew upgrade && brew cleanup -s'

alias ets='ember test --server --no-launch'

alias flush-dns='sudo killall -HUP mDNSResponder'

(( $+commands[hub] )) && alias git=hub

alias history='fc -il 1'

alias my-ip='dig +short myip.opendns.com @resolver1.opendns.com'

alias nom='rm -rf dist node_modules tmp; npm i'

alias path='echo $PATH | tr -s ":" "\n"'

alias trt='touch tmp/restart.txt'
