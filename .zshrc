export PATH="$HOME/bin:$PATH"

[[ -f "$HOME/.asdf/asdf.sh" ]] && source $HOME/.asdf/asdf.sh

for config in ~/.zsh/configs/*; do
  source $config
done

[[ -f "$HOME/.zshrc.local" ]] && source $HOME/.zshrc.local
