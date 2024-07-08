set -gx GOPRIVATE github.com/remerge
set -gx EDITOR $(brew --prefix)/bin/nvim

starship init fish | source

set PATH $PATH /usr/sbin

source $(brew --prefix)/opt/asdf/libexec/asdf.fish
source $HOME/.config/fish/aliases.fish

set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.cargo/bin
set PATH $PATH $HOME/.config/scripts

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/roman/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
