#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# SHORTCUTS

mkcd ()
{
	mkdir -p -- "$1" && cd -P -- "$1"
}

function ranger-cd {
    # create a temp file and store the name
    tempfile="$(mktemp -t tmp.XXXXXX)"

    # run ranger and ask it to output the last path into the
    # temp file
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"

    # if the temp file exists read and the content of the temp
    # file was not equal to the current path
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        # change directory to the path in the temp file
        cd -- "$(cat "$tempfile")"
    fi

    # its not super necessary to have this line for deleting
    # the temp file since Linux should handle it on the next
    # boot
    rm -f -- "$tempfile"
}

alias rc=ranger-cd
alias ls='ls --color=auto -a'
alias grep='grep --color=auto'
alias top='gotop --nvidia'
alias bspwm='startx /usr/bin/bspwm'
alias nivm='nvim'
PS1="\[\e[0;32m\]\u\[\e[0m\]: \[\e[0;34m\]\w \[\e[0m\]"

export VISUAL=nvim
export EDITOR=nvim

