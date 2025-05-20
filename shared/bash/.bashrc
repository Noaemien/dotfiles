#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
set -o vi

CONFIG_FOLDER="$HOME/.config/bash"

# ALIASES
source "$CONFIG_FOLDER/aliases.sh"
source "$CONFIG_FOLDER/shortcuts.sh"

PS1="\[\e[0;32m\]\u\[\e[0m\]: \[\e[0;34m\]\w \[\e[0m\]"

export VISUAL=nvim
export EDITOR=nvim
export RANGER_LOAD_DEFAULT_RC=FALSE

export PATH="~/scripts:$PATH"

#PRIVATE CONFIGS AND KEYS
source ~/emien_api

prompt_command() {
  # initialize the timestamp, if it isn't already
  _shortcuts_timestamp=${_shortcuts_timestamp:-$(stat -L -f %m "$CONFIG_FOLDER/nav_folders.json")}
  # if it's been modified, test and load it
  if [[ $(stat -L -f %m "$CONFIG_FOLDER/nav_folders.json") -gt $_shortcuts_timestamp ]]
  then
    # # only load it if `-n` succeeds ...
    # if $BASH -n "$HOME/.bashrc" >& /dev/null
    # then
    #     source "$HOME/.bashrc"
    # else
    #     printf "Error in $HOME/.bashrc; not sourcing it\n" >&2
    # fi
    # ... but update the timestamp regardless
    printf "Updating Folder Key Jumps\n"
    python "$HOME/scripts/generateShortcuts.py"
    source "$HOME/.bashrc"
    _shortcuts_timestamp=$(stat -L -f %m "$CONFIG_FOLDER/nav_folders.json")
  fi
}

PROMPT_COMMAND='prompt_command'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

