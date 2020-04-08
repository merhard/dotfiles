export PATH="$HOME/.bin:$PATH"

[ -x /usr/local/bin/asdf ] && source $(brew --prefix asdf)/asdf.sh

for config in ~/.zsh/configs/*; do
  source $config
done

[[ -f "$HOME/.zshrc.local" ]] && source $HOME/.zshrc.local
