#!/bin/bash

# Path to the banner file
BANNER_FILE="/etc/motd"
cat > $BANNER_FILE << EOF
U _____ u   __  __                 U _____ u   _   _     
\| ___"|/ U|' \/ '|u      ___      \| ___"|/  | \ |"|    
 |  _|"   \| |\/| |/     |_"_|      |  _|"   <|  \| |>   
 | |___    | |  | |       | |       | |___   U| |\  |u   
 |_____|   |_|  |_|     U/| |\u     |_____|   |_| \_|    
 <<   >>  <<,-,,-.   .-,_|___|_,-.  <<   >>   ||   \\,-. 
(__) (__)  (./  \.)   \_)-' '-(_/  (__) (__)  (_")  (_/  


EOF


# Header for the banner
echo "Welcome to $(hostname) SSH Server" >> "$BANNER_FILE"
echo "----------------------------------------" >> "$BANNER_FILE"

# Section for SSH connections
echo "Recent Successful SSH Connections:" >> "$BANNER_FILE"
# Extract successful SSH logins from journalctl
journalctl -u sshd --since "7 days ago" | grep "Accepted" | tail -n 5 | while read -r line; do
    # Extract IP and timestamp
    ip=$(echo "$line" | grep -oP '(?<=from )[\d.]+(?= port)')
    timestamp=$(echo "$line" | awk '{print $1, $2, $3}')
    echo "$timestamp - $ip" >> "$BANNER_FILE"
done

echo "" >> "$BANNER_FILE"
echo "Recent Caddy API Requests:" >> "$BANNER_FILE"
# Extract recent Caddy requests from access.log
if [ -s "/var/log/caddy/access.log" ]; then
cat /var/log/caddy/access.log | jq '. | if (.status < 300) and (.status >= 200) and (.request.uri != "/") then {ip: .request.remote_ip, uri: .request.uri, ts: .ts} else null end // empty' -r | jq -r -s 'sort_by(-.ts) | unique_by(.ip, .uri) | sort_by(.ts)[] | "\(.ts | strftime("%b %d %H:%M:%S")), ip: \(.ip), uri: \(.uri)"' | tail -n 5 >> "$BANNER_FILE"
#    # Use jq to parse valid JSON lines, skip invalid ones
#    cat /var/log/caddy/access.log | while read -r line; do
#        # Check if line is valid JSON and has required fields
#        if echo "$line" | jq -e '.request.remote_ip and .request.uri' >/dev/null 2>&1; then
#            echo "$line" | jq -r '. | "\(.ts | strftime("%b %d %H:%M:%S")) - \(.request.remote_ip) - \(.request.uri)"' >> "$BANNER_FILE"
#        fi
#    done | tail -n 5
else
    echo "No Caddy logs found" >> "$BANNER_FILE"
fi

echo "\n" >> "$BANNER_FILE"

chmod 644 "$BANNER_FILE"
