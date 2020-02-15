# User configuration
ZSH_THEME="pi"

plugins=(
	git
	colored-man-pages
	command-not-found
	cp
	safe-paste
	sudo
	zsh-syntax-highlighting
	zsh-z
)

# 
export ZSH="/home/michael/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# git aliases
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gpush="git push"
alias gac="git add . && git commit -a -m"
alias ls="exa"

# other aliases
alias usage="du -h -dl"
