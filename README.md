# EMIEN DOTFILES

Organisation:
- linux
  - bspwm
  - sxhkd
  - keyd
  - picom 
- macos
  - aerospace
  - karabiner
  - choose
- shared
  - editorconfig
  - bash
  - bg
  - git
  - kitty
  - nvim
  - ranger
  - scripts
  - ssh
  - tmux

## Term:
### Design philosophy
Least keystrokes to get to where you want to be.

### Method
#### Jumps
Navigation config common to ranger, nvim, bashrc.
**Jump to dir:**
- ,g + letter: jumps to dir defined by letter
- for hierarchical structures with same first letter, add one letter per child.
- example: ,gdd jumps to $HOME/documents/dev/
- configured in nav_folders.json

**Jump to config file:**
- ,c + letter: opens file defined by letter in nvim
- example: ,cb opens .bashrc in nvim
- configured in nav_config.json

#### FZF
FZF search to jump to given path, ignoring useless hidden folders.
