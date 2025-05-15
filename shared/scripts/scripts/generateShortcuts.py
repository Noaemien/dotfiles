import json

with open('/Users/emien/.config/bash/nav_folders.json', 'r') as s:
  data = json.load(s)

bash_buf = "#!/bin/bash\n"
ranger_buf = ""
for key,path in data.items():
  bash_buf += "alias " + key + "='fzf_tmux " + path +"'\n"
  ranger_buf += "map " + key + " cd " + path + "\n"

with open('/Users/emien/.config/bash/shortcuts.sh', 'w+') as s:
  print(bash_buf, file=s)

with open('/Users/emien/.config/ranger/shortcuts.conf', 'w+') as s:
  print(ranger_buf, file=s)


  
  


