# Install Homebrew
```shell
xcode-select --install

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

# Install ZSH
```shell
brew install zsh
which zsh | pbcopy
sudo vim /etc/shells
# Go<CMD+v><Esc>:wq
chsh -s $(which zsh)
```

# Setup SSH Key
https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

# Install Dotfiles
```shell
git clone git@github.com:merhard/dotfiles.git ~/dotfiles
~/dotfiles/install
```

# Install packages
```shell
brew install wget
brew install git
brew install hub
brew install the_silver_searcher
brew install vim
brew install watchman

brew install postgresql
brew services start postgresql

brew install redis
brew services start redis
```

# Install applications
- Sophos Antivirus from website
- Moom from App Store (for license)
- Remaining from Homebrew:
```shell
brew cask install 1password
brew cask install adobe-acrobat-reader
brew cask install alfred
brew cask install caffeine
brew cask install dash
brew cask install dropbox
brew cask install flux
brew cask install google-chrome
brew cask install gpg-suite
brew cask install rowanj-gitx
brew cask install slack
brew cask install sublime-text

brew tap homebrew/cask-drivers
brew cask install logitech-options
brew cask install logitech-unifying
```

# Install ASDF
https://github.com/asdf-vm/asdf
```shell
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.5.0

brew install autoconf
brew install automake
brew install coreutils
brew install libtool
brew install libxslt
brew install libyaml
brew install openssl
brew install readline
brew install unixodbc
```

# Install Node.js
```shell
asdf plugin-add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf list-all nodejs | tail -1
asdf install nodejs <version>
asdf global nodejs <version>
brew install yarn --without-node
```

# Install Ruby
```shell
asdf plugin-add ruby
asdf list-all ruby | tail -1
asdf install ruby <version>
asdf global ruby <version>
```

# Setup Bundler
```shell
sysctl -n hw.ncpu
bundle config --global jobs <number_of_cores - 1>
```
