set -gx GOPRIVATE github.com/remerge
set -gx EDITOR /usr/local/bin/nvim

starship init fish | source

source /usr/local/opt/asdf/libexec/asdf.fish
source $HOME/.config/fish/aliases.fish

# Created by `pipx` on 2023-06-22 08:52:01
set PATH $PATH /Users/roman/.local/bin
set PATH $PATH /Users/roman/.cargo/bin
set PATH $PATH /Users/roman/.config/scripts
set PKG_CONFIG_PATH $PKG_CONFIG_PATH $(brew --prefix)/lib/pkgconfig
