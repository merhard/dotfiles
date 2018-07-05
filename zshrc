for config in ~/.zsh/configs/*; do
  source $config
done

[[ -f "~/.zshrc.local" ]] && source ~/.zshrc.local
