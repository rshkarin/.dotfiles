#!/usr/bin/env bash
#
# Bootstrap script for setting up a new OSX machine
#
# This should be idempotent so it can be run multiple times.
# 
# Original: https://gist.github.com/mrichman/f5c0c6f0c0873392c719265dfd209e12

# helpers
function echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error() { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

echo_ok "Install starting. You may be asked for your password (for sudo)."

# requires xcode and tools!
xcode-select -p || exit "XCode must be installed from the AppStore!"

# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
if hash brew &>/dev/null; then
	echo_ok "Homebrew already installed. Getting updates..."
	brew update
	brew doctor
else
	echo_warn "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
# brew install coreutils
# brew install gnu-sed --with-default-names
# brew install gnu-tar --with-default-names
# brew install gnu-indent --with-default-names
# brew install gnu-which --with-default-names
# brew install gnu-grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
# brew install findutils

# Install Bash
brew install bash

PACKAGES=(
    asdf
	ansible
	awscli
    bat
	bash-completion
	bash-git-prompt
    coreutils
	cookiecutter
	curl
    cowsay
    cmake
    copier
    direnv
    eg-examples
    fish
    fd
    ffmpeg
    fzf
	git
    git-extras
    gh
    glow
	btop
	htop
    ripgrep
	jq
    kubectl	
    lazygit
    lua
    luarocks
    nomad
    neovim
	pipenv
	python3
	pyenv
    pre-commit
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
	terraform
	thefuck
	tree
    terminal-notifier
    tldr
    tmux
    virtualenv
	watch
	wget
	youtube-dl
    yarn
	# zsh
	# zsh-autosuggestions
	# zsh-completions
	# zsh-syntax-highlighting
)

echo_ok "Installing packages..."
brew install "${PACKAGES[@]}"

echo_ok "Cleaning up..."
brew cleanup

echo_ok "Installing cask..."
# brew install caskroom/cask/brew-cask
brew tap caskroom/cask

CASKS=(
    1password
    alacritty
    adobe-creative-cloud
    discord
    orbstack	
	google-chrome
    google-drive
	google-cloud-sdk
    notion
    telegram
    tailscale
	skype
	slack
	spotify
    intellij-idea
	visual-studio-code
	vlc
    zoom
)

echo_ok "Installing cask apps..."
brew install --cask "${CASKS[@]}"

echo_ok "Installing fonts..."
brew tap homebrew/cask-fonts
FONTS=(
    font-fira-code-nerd-font
    font-jetbrains-mono-nerd-font
)
brew cask install "${FONTS[@]}"

echo_ok "Installing asdf plugins..."
ASDF_PLUGINS=(
	python
	go
	ruby
    rust
)
for i in "${ASDF_PLUGINS[@]}"; do
	asdf plugin add "$i"
done

echo_ok "Installing fish shell plugin manager..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

echo_ok "Installing development environtment..."
git clone https://github.com/rshkarin/.dotfiles.git ~/.dotfiles

config_dir="$HOME/.config"
if [ ! -d "$config_dir" ]; then
    echo_ok "Creating ~/.config directory..."
    mkdir -p "$config_dir"
fi

# Function to create symlink and backup existing folder if necessary
create_symlink() {
    local target="$1"
    local link_name="$2"

    if [ -e "$link_name" ]; then
        echo_warn "Backup existing $link_name to $link_name.bkp"
        mv "$link_name" "$link_name.bkp"
    fi

    echo_ok "Creating symlink $link_name -> $target"
    ln -s "$target" "$link_name"
}

# Create symlinks for nvim, alacritty, and fish
create_symlink "$HOME/.dotfiles/nvim" "$config_dir/nvim"
create_symlink "$HOME/.dotfiles/alacritty" "$config_dir/alacritty"
create_symlink "$HOME/.dotfiles/fish" "$config_dir/fish"

echo_ok "Installing fish shell plugins..."
FISH_PLUGINS=(
    jorgebucaran/fisher
    PatrickF1/fzf.fish
    jomik/fish-gruvbox
    h-matsuo/fish-color-scheme-switcher
    danhper/fish-ssh-agent
    meaningful-ooo/sponge
    franciscolourenco/done
)
fisher install "${FISH_PLUGINS[@]}" 

echo_ok "Configuring Github"
if [[ ! -f ~/.ssh/id_rsa ]]; then
	echo ''
	echo '##### Please enter your git username: '
	read git_user
	echo '##### Please enter your git email address: '
	read git_email

	# setup github
	if [[ $git_user && $git_email ]]; then
		# setup config
		git config --global user.name "$git_user"
		git config --global user.email "$git_email"
	fi
fi

# Set fast key repeat rate
# The step values that correspond to the sliders on the GUI are as follow (lower equals faster):
# KeyRepeat: 120, 90, 60, 30, 12, 6, 2
# InitialKeyRepeat: 120, 94, 68, 35, 25, 15
# defaults write NSGlobalDomain KeyRepeat -int 6
# defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Always show scrollbars
# defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

echo_ok 'Running OSX Software Updates...'
sudo softwareupdate -i -a

echo_ok "Creating folder structure..."
[[ ! -d ~/Work ]] && mkdir ~/Work 

echo_ok "Bootstrapping complete"
