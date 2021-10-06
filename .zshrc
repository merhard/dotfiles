export PATH="$HOME/bin:$PATH"

[[ -f /usr/local/opt/asdf/asdf.sh ]] && source /usr/local/opt/asdf/asdf.sh

for config in ~/.zsh/configs/*; do
  source $config
done

[[ -f "$HOME/.zshrc.local" ]] && source $HOME/.zshrc.local
