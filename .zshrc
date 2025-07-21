# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Alias
alias vim=nvim

# set GO path
export GOPATH=$HOME/go 
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export TZ="America/Sao_Paulo" # used for hyprlock

autoload -U colors && colors
PS1="%{$fg[green]%}%c %{$reset_color%}%% "

# End of lines configured by zsh-newuser-install
