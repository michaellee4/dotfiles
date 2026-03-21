export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
alias vim=nvim

# Enable colors
autoload -U colors && colors

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'


# Syntax highlighting (must be last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf shell integration
eval "$(fzf --zsh)"

# Starship prompt
eval "$(starship init zsh)"

# Colored ls output
export CLICOLOR=1
export LSCOLORS=ExGxFxDxCxegedabagaced
alias ls='ls -G'

# Quick reload
alias src='source ~/.zshrc'

# raspberrypi
alias pi='ssh milee@pilee'

# Yazi wrapper - cd to last directory on exit
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
