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
    status_prompt="%{%F{red}%}%{✗%G%}%{%f%}"
  else
    status_prompt="%{%F{green}%}%{✓%G%}%{%f%}"
  fi

  echo "$status_prompt $branch_prompt"
}

ruby_prompt () {
  # Show version only for Ruby-specific folders
  [[ -f Gemfile || -f Rakefile || -n *.rb(#qN^/) ]] || return

  if (( $+commands[asdf] )); then
    ruby_version=$(asdf current ruby | ruby -ane 'puts $F[1]')
  else
    ruby_version=$(ruby --version | ruby -ane 'puts $F[1].split("p")[0]')
  fi

  echo " %{%F{red}%}ruby-$ruby_version%{%f%}"
}

elixir_prompt () {
  # Show version only for Elixir-specific folders
  [[ -f mix.exs || -n *.ex(#qN^/) || -n *.exs(#qN^/) ]] || return

  if (( $+commands[asdf] )); then
    elixir_version=$(asdf current elixir | ruby -ane 'puts $F[1].split("-")[0]')
  else
    elixir_version=$(elixir --version | tail -1 | ruby -ane 'puts $F[1]')
  fi

  echo " %{%F{magenta}%}elixir-$elixir_version%{%f%}"
}

node_prompt () {
  # Show version only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  if (( $+commands[asdf] )); then
    node_version=$(asdf current nodejs | ruby -ane 'puts $F[1]')
  elif (( $+commands[nodejs] )); then
    node_version=$(nodejs --version | ruby -pe 'sub(/^v/, "")')
  else
    node_version=$(node --version | ruby -pe 'sub(/^v/, "")')
  fi

  echo " %{%F{green}%}node-$node_version%{%f%}"
}

time_prompt="%{%F{yellow}%}%T%{%f%}"
username_prompt="%{%F{blue}%}%n%{%f%}"
machine_prompt="%{%B%F{red}%}%m%{%f%b%}"
dir_prompt="%{%F{cyan}%}%~%{%f%}"

RPROMPT="%{$(echotc UP 1)%}\$(git_prompt)\$(ruby_prompt)\$(elixir_prompt)\$(node_prompt)%{$(echotc DO 1)%}"
PROMPT="$time_prompt $username_prompt@$machine_prompt:$dir_prompt
$ "
