import json

with open('/Users/emien/.config/bash/nav_folders.json', 'r') as s:
  data = json.load(s)

buf = "#!/bin/bash\n"
for key,path in data.items():
  buf += "alias " + key + "='fzf_tmux " + path +"'\n"

with open('/Users/emien/.config/bash/shortcuts.sh', 'w+') as s:
  print(buf, file=s)


  
  


