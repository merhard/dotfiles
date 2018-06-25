##### ALIAS ###################################################################
alias buo='brew update && brew outdated'
alias buc='brew upgrade --cleanup && brew cleanup -s'

alias ets='ember test --server --no-launch'

alias flush-dns='sudo killall -HUP mDNSResponder'

alias git=hub

alias history='fc -il 1'

alias my-ip='dig +short myip.opendns.com @resolver1.opendns.com'

alias path='echo $PATH | tr -s ":" "\n"'

alias trt='touch tmp/restart.txt'

##### AUTOBIN #################################################################
function _rails_command () {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ] && grep '\srails\s' Gemfile.lock; then
    bundle exec rails $@
  else
    command rails $@
  fi
}
alias rails='_rails_command'

function _rake_command () {
  if [ -e "bin/rake" ]; then
    bin/rake $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ] && grep '\srake\s' Gemfile.lock; then
    bundle exec rake $@
  else
    command rake $@
  fi
}
alias rake='_rake_command'

function _rspec_command () {
  if [ -e "bin/rspec" ]; then
    bin/rspec $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ] && grep '\srspec-core\s' Gemfile.lock; then
    bundle exec rspec $@
  else
    command rspec $@
  fi
}
alias rspec='_rspec_command'

##### COMPLETIONS #############################################################
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

[[ -d "$HOME/.asdf" ]] && source $HOME/.asdf/completions/asdf.bash

##### EDITOR ##################################################################
export EDITOR=vim
export BUNDLER_EDITOR=subl

##### HISTORY #################################################################
HISTFILE=$HOME/.zsh_history

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

##### KEY-BINDINGS ############################################################
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings

bindkey '^r' history-incremental-search-backward

bindkey ' ' magic-space                               # [Space] - do history expansion

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

##### MISC ####################################################################
export DISABLE_SPRING=1

##### PATH ####################################################################
setopt auto_cd
cdpath=(
  ~/dev
  ~
)

##### PROMPT ##################################################################
setopt extended_glob
setopt prompt_subst

autoload -U colors
colors

git_prompt () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  branch_prompt="%{%F{136}%}${ref#refs/heads/}%{$reset_color%}"

  git_status=$(command git status -s --ignore-submodules=dirty 2> /dev/null | tail -n1)
  if [[ -n $git_status ]]; then
    status_prompt="%{$fg[red]%}✗%{$reset_color%}"
  else
    status_prompt="%{$fg[green]%}✓%{$reset_color%}"
  fi

  echo "$status_prompt $branch_prompt"
}

ruby_prompt () {
  # Show versions only for Ruby-specific folders
  [[ -f Gemfile || -f Rakefile || -n *.rb(#qN^/) ]] || return

  local ruby_version=$(asdf current ruby | awk '{print $1}')
  [[ -z $ruby_version || "${ruby_version}" == "system" ]] && return

  echo " %{%F{red}%}ruby-$ruby_version%{$reset_color%}"
}

node_prompt () {
  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  local node_version=$(asdf current nodejs | awk '{print $1}')

  echo " %{%F{green}%}node-$node_version%{$reset_color%}"
}

time_prompt="%{$fg[yellow]%}%T%{$reset_color%}"
session_prompt="%{$fg[blue]%}%n@%m%{$reset_color%}"
dir_prompt="%{$fg[cyan]%}%~%{$reset_color%}"

RPROMPT="%{$(echotc UP 1)%}\$(git_prompt)\$(ruby_prompt)\$(node_prompt)%{$(echotc DO 1)%}"
PROMPT="$time_prompt $session_prompt:$dir_prompt
➭ "

##### TERMINAL ################################################################
## Set terminal tab title
# https://github.com/robbyrussell/oh-my-zsh/blob/d848c94804918138375041a9f800f401bec12068/lib/termsupport.zsh#L1-L79
function title {
  emulate -L zsh
  setopt prompt_subst

  print -Pn "\e]1;$1:q\a"
}

function termsupport_precmd {
  emulate -L zsh

  local ZSH_THEME_TERM_TAB_TITLE_IDLE="%25<..<%~%<<"

  title $ZSH_THEME_TERM_TAB_TITLE_IDLE
}

function termsupport_preexec {
  emulate -L zsh
  setopt extended_glob

  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}

  title '$CMD'
}

precmd_functions+=(termsupport_precmd)
preexec_functions+=(termsupport_preexec)

## Tell the terminal about the current working directory
# https://superuser.com/questions/313650/resume-zsh-terminal-os-x-lion/315029#answer-328148
# https://github.com/robbyrussell/oh-my-zsh/blob/d848c94804918138375041a9f800f401bec12068/lib/termsupport.zsh#L82-L105
function update_terminalapp_cwd() {
  emulate -L zsh

  local URL_PATH=''
  {
    local i ch hexch LC_CTYPE=C
    for ((i = 1; i <= ${#PWD}; ++i)); do
      ch="$PWD[i]"
      if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
        URL_PATH+="$ch"
      else
        hexch=$(printf "%02X" "'$ch")
        URL_PATH+="%$hexch"
      fi
    done
  }

  printf '\e]7;%s\a' "file://$HOST$URL_PATH"
}

precmd_functions+=(update_terminalapp_cwd)
update_terminalapp_cwd

##### ZSHRC LOCAL #############################################################
[[ -f "~/.zshrc.local" ]] && source ~/.zshrc.local
