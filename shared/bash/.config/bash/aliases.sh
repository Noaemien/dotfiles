#!/bin/bash

mkcd ()
{
	mkdir -p -- "$1" && cd -P -- "$1"
}

alias ls='ls --color=auto -a'
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



alias sail='vendor/bin/sail'
alias a='vendor/bin/sail artisan'
alias dep='vendor/bin/dep'
