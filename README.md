# Install Homebrew

```shell
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install wget
```

# Install ZSH

```shell
brew install zsh
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)
```

# Install packages

```shell
brew install git
brew install hub
brew install the_silver_searcher
brew install vim
brew install watchman
brew install yarn

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
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install flux
brew cask install google-chrome
brew cask install gpg-suite
brew cask install postico
brew cask install slack
brew cask install sublime-merge
brew cask install sublime-text
brew cask install zsa-wally

brew tap homebrew/cask-drivers
brew cask install logitech-options
brew cask install logitech-unifying
```

# Install ASDF

https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm

```shell
brew install asdf

brew install autoconf
brew install automake
brew install coreutils
brew install curl
brew install libffi
brew install libtool
brew install libxslt
brew install libyaml
brew install openssl
brew install readline
brew install unixodbc
brew install unzip
brew install wxmac
```

# Install Node.js

```shell
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

~/.asdf/plugins/nodejs/bin/import-release-team-keyring

NODEJS_VERSION=$(asdf list all nodejs | tail -1) &&
  asdf install nodejs $NODEJS_VERSION &&
  asdf global nodejs $NODEJS_VERSION

npm install -g npm
```

# Install Ruby

```shell
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

RUBY_VERSION=$(asdf list all ruby | grep -v "[a-z]" | tail -1) &&
  asdf install ruby $RUBY_VERSION &&
  asdf global ruby $RUBY_VERSION
```

# Setup Bundler

```shell
sysctl -n hw.ncpu
bundle config --global jobs <number_of_cores - 1>
```

# Setup SSH Key

https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

# Install Dotfiles

```shell
git clone git@github.com:merhard/dotfiles.git ~/dotfiles
~/dotfiles/install
```

# Edit MacOS Settings

```shell
# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder
```
