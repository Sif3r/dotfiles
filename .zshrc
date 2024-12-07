# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"
#
# Start tmux if not already running within a tmux session.
if [ "$TMUX" = "" ]; then tmux; fi

# Set the number of commands to remember in the command history.
HISTSIZE=1000
SAVEHIST=1000

plugins=(git
	git-extras
	archlinux
	zsh-syntax-highlighting
	zsh-autosuggestions)


# Source the Oh My Zsh main script
source $ZSH/oh-my-zsh.sh

# Aliases
alias t="tree"
alias nv="nvim"
alias ls="exa"

# Initialize Starship, a cross-shell prompt
eval "$(starship init zsh)"
