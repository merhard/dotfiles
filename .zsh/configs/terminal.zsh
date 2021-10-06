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
