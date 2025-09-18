eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/usr/local/bin:$PATH"

# Rust binaries
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Go binaries
export GOBIN="$HOME/go/bin"
export PATH="$GOBIN:$PATH"

export PATH="$HOME/.config/scripts:$PATH"

# Ruby (rbenv shims)
eval "$(rbenv init - zsh)"


export EDITOR="nvim"

alias ll='ls -lah'
alias gs='git status'
alias v='nvim'
alias vi='nvim'
alias df='df -m'
alias gti='git'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$PATH:/Users/roman/Library/Python/3.11/bin"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Enable completion
autoload -Uz compinit && compinit

# Key bindings for history search
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Load plugins (install via package manager or manually)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# fzf integration
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="
  --height=80%
  --layout=reverse
  --info=inline
  --border=rounded
  --margin=1
  --padding=1
  --color=bg+:#2a273f,bg:#232136,spinner:#f6c177,hl:#ea9a97
  --color=fg:#e0def4,header:#ea9a97,info:#c4a7e7,pointer:#f6c177
  --color=marker:#eb6f92,fg+:#e0def4,prompt:#c4a7e7,hl+:#ea9a97
  --color=border:#44415a,gutter:#232136"

export FZF_TMUX=1
export FZF_TMUX_OPTS="-p90%,70%"

# starship integration
eval "$(starship init zsh)"

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
