setopt extended_glob
setopt prompt_subst

autoload -U colors
colors

git_prompt () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  branch_prompt="%{%F{136}%}${ref#refs/heads/}%{%f%}"

  git_status=$(command git status -s --ignore-submodules=dirty 2> /dev/null | tail -n1)
  if [[ -n $git_status ]]; then
    status_prompt="%{%F{red}%}✗%{%f%}"
  else
    status_prompt="%{%F{green}%}✓%{%f%}"
  fi

  echo "$status_prompt $branch_prompt"
}

ruby_prompt () {
  # Show versions only for Ruby-specific folders
  [[ -f Gemfile || -f Rakefile || -n *.rb(#qN^/) ]] || return

  local ruby_version=$(asdf current ruby | awk '{print $1}')
  [[ -z $ruby_version || "${ruby_version}" == "system" ]] && return

  echo " %{%F{red}%}ruby-$ruby_version%{%f%}"
}

node_prompt () {
  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  local node_version=$(asdf current nodejs | awk '{print $1}')

  echo " %{%F{green}%}node-$node_version%{%f%}"
}

time_prompt="%{%F{yellow}%}%T%{%f%}"
session_prompt="%{%F{blue}%}%n@%m%{%f%}"
dir_prompt="%{%F{cyan}%}%~%{%f%}"

RPROMPT="%{$(echotc UP 1)%}\$(git_prompt)\$(ruby_prompt)\$(node_prompt)%{$(echotc DO 1)%}"
PROMPT="$time_prompt $session_prompt:$dir_prompt
➭ "
