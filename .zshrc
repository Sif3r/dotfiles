export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

plugins=(
  git
  git-extras
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
source <(fzf --zsh)

alias t="tree"
alias nv="nvim"
alias g="git"
alias l="ls -al"

if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]]; then
    exec tmux new-session -A -s main
fi
