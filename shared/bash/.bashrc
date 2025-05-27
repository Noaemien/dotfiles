#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
set -o vi

CONFIG_FOLDER="$HOME/.config/bash"

PS1="\[\e[0;32m\]\u\[\e[0m\]: \[\e[0;34m\]\w \[\e[0m\]"

export VISUAL=nvim
export EDITOR=nvim
export RANGER_LOAD_DEFAULT_RC=FALSE
export FZF_DEFAULT_OPTS="--multi --no-height --extended"

export PATH="~/scripts:$PATH"

# ALIASES
source "$CONFIG_FOLDER/aliases.sh"
source "$CONFIG_FOLDER/shortcuts.sh"
#PRIVATE CONFIGS AND KEYS
source ~/emien_api

prompt_command() {
  # initialize the timestamp, if it isn't already
  _nav_folders_timestamp=${_nav_folders_timestamp:-$(stat -L -f %m "$CONFIG_FOLDER/nav_folders.json")}
  _nav_config_timestamp=${_nav_config_timestamp:-$(stat -L -f %m "$CONFIG_FOLDER/nav_config.json")}
  # if it's been modified, test and load it
  if [[ $(stat -L -f %m "$CONFIG_FOLDER/nav_folders.json") -gt $_nav_folders_timestamp || $(stat -L -f %m "$CONFIG_FOLDER/nav_config.json") -gt $_nav_config_timestamp ]];
  then
    printf "Updating Folder Key Jumps\n"
    python "$HOME/scripts/generateShortcuts.py"
    source "$CONFIG_FOLDER/shortcuts.sh"

    _nav_folders_timestamp=$(stat -L -f %m "$CONFIG_FOLDER/nav_folders.json")
    _nav_config_timestamp=$(stat -L -f %m "$CONFIG_FOLDER/nav_config.json")
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

