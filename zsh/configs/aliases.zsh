alias buo='brew update && brew outdated'
alias buc='brew upgrade --cleanup && brew cleanup -s'

alias ets='ember test --server --no-launch'

alias flush-dns='sudo killall -HUP mDNSResponder'

alias git=hub

alias history='fc -il 1'

alias my-ip='dig +short myip.opendns.com @resolver1.opendns.com'

alias path='echo $PATH | tr -s ":" "\n"'

alias trt='touch tmp/restart.txt'
