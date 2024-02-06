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
	# bash-completion
	# bash-git-prompt
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
    luajit
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
	adobe-acrobat-reader
	alfred
	appcleaner
	appzapper
	atom
	cakebrew
	calibre
	colloquy
	cyberduck
	daisydisk
	deluge
	docker
	dropbox
	evernote
	firefox
	flycut
	github
	gitter
	google-chrome
	google-cloud-sdk
	google-hangouts
	handbrake
	iterm2
	keka
	keybase
	kindle
	lingon-x
	liya
	macvim
	microsoft-azure-storage-explorer
	microsoft-remote-desktop-beta
	mysqlworkbench
	textmate
	microsoft-teams
	mpv
	qbittorrent
	qlstephen
	sequel-pro
	skitch
	skype
	slack
	sourcetree
	spotify
	spotify-notifications
	sublime-text
	teamviewer
	torbrowser
	transmission
	vagrant
	virtualbox
	virtualbox
	visual-studio-code
	vlc
	vlc
	whatsapp
	xact
)

echo_ok "Installing cask apps..."
brew cask install "${CASKS[@]}"

# brew cask quicklook
echo_ok "Installing QuickLook Plugins..."
brew cask install \
	qlcolorcode qlmarkdown qlprettypatch qlstephen \
	qlimagesize \
	quicklook-csv quicklook-json epubquicklook

echo_ok "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
	font-clear-sans
	font-consolas-for-powerline
	font-dejavu-sans-mono-for-powerline
	font-fira-code
	font-fira-mono-for-powerline
	font-inconsolata
	font-inconsolata-for-powerline
	font-liberation-mono-for-powerline
	font-menlo-for-powerline
	font-roboto
)
brew cask install "${FONTS[@]}"

echo_ok "Installing Python packages..."
PYTHON_PACKAGES=(
	ipython
	virtualenv
	virtualenvwrapper
)
sudo pip install "${PYTHON_PACKAGES[@]}"

echo "Installing Ruby gems"
RUBY_GEMS=(
	bundler
	rake
)
sudo gem install "${RUBY_GEMS[@]}"

echo_ok "Installing global npm packages..."

npm install -g aws-sam-local
npm install -g spaceship-prompt

echo_ok "Installing oh my zsh..."

if [[ ! -f ~/.zshrc ]]; then
	echo ''
	echo '##### Installing oh-my-zsh...'
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

	cp ~/.zshrc ~/.zshrc.orig
	cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
	chsh -s /bin/zsh
fi

echo_ok "Configuring Github"

if [[ ! -f ~/.ssh/id_rsa ]]; then
	echo ''
	echo '##### Please enter your github username: '
	read github_user
	echo '##### Please enter your github email address: '
	read github_email

	# setup github
	if [[ $github_user && $github_email ]]; then
		# setup config
		git config --global user.name "$github_user"
		git config --global user.email "$github_email"
		git config --global github.user "$github_user"
		# git config --global github.token your_token_here
		git config --global color.ui true
		git config --global push.default current
		# VS Code support
		git config --global core.editor "code --wait"

		# set rsa key
		curl -s -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain
		chmod u+x git-credential-osxkeychain
		sudo mv git-credential-osxkeychain "$(dirname $(which git))/git-credential-osxkeychain"
		git config --global credential.helper osxkeychain

		# generate ssh key
		cd ~/.ssh || exit
		ssh-keygen -t rsa -C "$github_email"
		pbcopy <~/.ssh/id_rsa.pub
		echo ''
		echo '##### The following rsa key has been copied to your clipboard: '
		cat ~/.ssh/id_rsa.pub
		echo '##### Follow step 4 to complete: https://help.github.com/articles/generating-ssh-keys'
		ssh -T git@github.com
	fi
fi

echo_ok "Installing VS Code Extensions..."

VSCODE_EXTENSIONS=(
	AlanWalk.markdown-toc
	CoenraadS.bracket-pair-colorizer
	DavidAnson.vscode-markdownlint
	DotJoshJohnson.xml
	EditorConfig.EditorConfig
	Equinusocio.vsc-material-theme
	HookyQR.beautify
	James-Yu.latex-workshop
	PKief.material-icon-theme
	PeterJausovec.vscode-docker
	Shan.code-settings-sync
	Zignd.html-css-class-completion
	akamud.vscode-theme-onedark
	akmittal.hugofy
	anseki.vscode-color
	arcticicestudio.nord-visual-studio-code
	aws-scripting-guy.cform
	bungcip.better-toml
	christian-kohler.npm-intellisense
	christian-kohler.path-intellisense
	codezombiech.gitignore
	dansilver.typewriter
	dbaeumer.jshint
	donjayamanne.githistory
	dracula-theme.theme-dracula
	eamodio.gitlens
	eg2.vscode-npm-script
	ipedrazas.kubernetes-snippets
	loganarnett.lambda-snippets
	lukehoban.Go
	mohsen1.prettify-json
	monokai.theme-monokai-pro-vscode
	ms-python.python
	ms-vscode.azure-account
	msjsdiag.debugger-for-chrome
	robertohuertasm.vscode-icons
	robinbentley.sass-indented
	waderyan.gitblame
	whizkydee.material-palenight-theme
	whtsky.agila-theme
	zhuangtongfa.Material-theme
	foxundermoon.shell-format
	timonwong.shellcheck
)

if hash code &>/dev/null; then
	echo_ok "Installing VS Code extensions..."
	for i in "${VSCODE_EXTENSIONS[@]}"; do
		code --install-extension "$i"
	done
fi

echo_ok "Configuring OSX..."

# Set fast key repeat rate
# The step values that correspond to the sliders on the GUI are as follow (lower equals faster):
# KeyRepeat: 120, 90, 60, 30, 12, 6, 2
# InitialKeyRepeat: 120, 94, 68, 35, 25, 15
defaults write NSGlobalDomain KeyRepeat -int 6
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Require password as soon as screensaver or sleep mode starts
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Expanded Save menu
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expanded Print menu
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo_ok 'Running OSX Software Updates...'
sudo softwareupdate -i -a

echo_ok "Creating folder structure..."
#[[ ! -d Wiki ]] && mkdir Wiki
#[[ ! -d Workspace ]] && mkdir Workspace

echo_ok "Bootstrapping complete"
