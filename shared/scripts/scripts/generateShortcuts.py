import json
import os


# FOLDERS
with open(os.environ.get("HOME", "/Users/emien") + '/.config/bash/nav_folders.json', 'r') as s:
  data = json.load(s)

bash_buf = "#!/bin/bash\n"
ranger_buf = ""
for key,path in data.items():
  bash_buf += "alias g" + key + "='fzf_tmux " + path +"'\n"
  ranger_buf += "map g" + key + " cd " + path + "\n"

# CONFIGS
with open('/Users/emien/.config/bash/nav_config.json', 'r') as s:
  data = json.load(s)

for key,path in data.items():
  bash_buf += "alias c" + key + "='nvim " + path +"'\n"
  ranger_buf += "map c" + key + " chain cd " + os.path.dirname(path) + "; search " + os.path.basename(path) +"; open_with nvim " + "\n"

# SAVE TO FILES 

with open('/Users/emien/.config/bash/shortcuts.sh', 'w+') as s:
  print(bash_buf, file=s)

with open('/Users/emien/.config/ranger/shortcuts.conf', 'w+') as s:
  print(ranger_buf, file=s)
