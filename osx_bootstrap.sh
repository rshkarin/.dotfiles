#!/usr/bin/env bash

# helpers
function echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error() { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

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

# Create symlinks for nvim, alacritty, and zsh
create_symlink "$HOME/.dotfiles/nvim" "$config_dir/nvim"
create_symlink "$HOME/.dotfiles/alacritty" "$config_dir/alacritty"
create_symlink "$HOME/.dotfiles/scripts" "$config_dir/scripts"
create_symlink "$HOME/.dotfiles/starship.toml" "$config_dir/starship.toml"
create_symlink "$HOME/.dotfiles/tmux.conf" "$HOME/tmux.conf"
create_symlink "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"

echo_ok "Configuring python keyring..."
cat << EOF > "$HOME/.config/python_keyring/keyringrc.cfg"
[backend]
default-keyring=keyring.backends.macOS.Keyring
EOF

echo_ok "Configuring git..."
echo '## Please enter your full name:'
read -r git_fullname
echo '## Please enter your git email address: '
read -r git_email
cat << EOF > "$HOME/.gitconfig"
[user]
    name = $git_fullname
    email = $git_email
    signingKey = $(op read "op://Shared/SSH Key Machine/public key") $git_email

[url "git@github.com:"]
    insteadOf = https://github.com/

[alias]
    co = checkout
    br = branch

[pull]
    rebase = true

[push]
    default = current

[gpg]
    format = ssh

[commit]
    gpgsign = true

[tag]
    gpgsign = true

[gpg "ssh"]
    allowedSignersFile = ~/.config/git/allowed_signers

[init]
    defaultBranch = master
EOF
echo "Git configuration file created at ~/.gitconfig"

echo_ok "Configuring SSH..."
cat << EOF > "$HOME/.ssh/config"
Include ~/.orbstack/ssh/config

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF

cat << EOF > "$HOME/.ssh/id_rsa.pub"
$(op read "op://Shared/SSH Key Machine/public key") $git_email
EOF
op read "op://Shared/SSH Key Machine/private key?ssh-format=openssh" > "$HOME/.ssh/id_rsa"

echo_ok 'Running OSX Software Updates...'
sudo softwareupdate -i -a

echo_ok "Creating folder structure..."
[[ ! -d ~/Work ]] && mkdir ~/Work

echo_ok "Bootstrapping complete"
