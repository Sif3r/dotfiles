export ZSH="/home/cypher/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(
  git
  git-extras
  zsh-syntax-highlighting
  zsh-autosuggestions
)

HISTSIZE=1000
SAVEHIST=1000

if [ -z "$TMUX" ]; then
  tmux
fi

# --- Aliases ---
alias t="tree"
alias nv="nvim"
#alias ls="eza"
alias l="ls -al"
alias g="git"
alias z="zoxide"

eval "$(starship init zsh)"

source <(fzf --zsh)
