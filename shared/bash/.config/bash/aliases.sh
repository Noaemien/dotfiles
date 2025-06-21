#!/bin/bash

mkcd ()
{
	mkdir -p -- "$1" && cd -P -- "$1"
}

c ()
{

  if [[ -e $1 ]] ; then
    path=$1
  else
    if [[ -e $ROOT ]] ; then
      path=$ROOT
    else
      path=$HOME
    fi
  fi
  cd $path 
}

venv ()
{
  VENV_PATH="$HOME/documents/dev/venv"
  [ -e $VENV_PATH ] || mkdir -p "$VENV_PATH"

  [ $1 == '-l' ] && { ls -1 $VENV_PATH 2>/dev/null || echo "No virtual environments"; }
  [ $1 == '-a' ] && { source "$VENV_PATH/$(venv -l | fzf)/bin/activate" 2>/dev/null || echo "Usage: venv -a <name>"; }
  [ $1 == '-n' ] && { [ -n $2 ] && python -m venv "$VENV_PATH/$2" || echo "Usage: venv -n <name>"; }
  [ $1 == '-d' ] && { deactivate || echo "Not in a virtual environments"; }
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias top='gotop --nvidia'
alias bspwm='startx /usr/bin/bspwm'

alias v='nvim'
alias r='ranger'
alias s='fzf_tmux'
alias sk='fzf_tmux_kill'
alias sp='fzf_tmux_purge'
alias g='lazygit'
alias go='cd $(fzf --walker=dir,follow,hidden --walker-skip=Library,Applications,.local,.cache,.git,miniconda3,node_modules,.vscode,.cargo)'
alias cd='c'



alias sail='vendor/bin/sail'
alias a='vendor/bin/sail artisan'
alias dep='vendor/bin/dep'
