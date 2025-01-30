#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -a'
alias grep='grep --color=auto'
alias top='gotop --nvidia'
PS1="\[\e[0;32m\]\u\[\e[0m\]: \[\e[0;34m\]\w \[\e[0m\]"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/emien/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/emien/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/emien/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/emien/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



# SHORTCUTS

mkcd ()
{
	mkdir -p -- "$1" && cd -P -- "$1"
}



