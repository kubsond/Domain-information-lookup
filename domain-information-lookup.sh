#!/bin/bash



red=$(tput setaf 1)
reset=$(tput sgr0)
echo "${red}Made by kubsondos#0565 / @kubsond${reset}"


read -p "Enter the internet domain: " domain


ip_address=$(dig +short "$domain")


ping_result=$(ping -c 4 "$domain" | tail -1)
ping_time=$(echo "$ping_result" | awk -F '/' 'END{print $5}')


robots_txt=$(curl -s -I "https://$domain/robots.txt" | grep -i "HTTP/1.1" | awk '{print $2}')


port_80_status=$(nc -z -w1 "$domain" 80 &>/dev/null && echo "open" || echo "closed")
port_443_status=$(nc -z -w1 "$domain" 443 &>/dev/null && echo "open" || echo "closed")
port_21_status=$(nc -z -w1 "$domain" 21 &>/dev/null && echo "open" || echo "closed")




echo "1. IP address: $ip_address"
echo "2. Ping to the site: $ping_time ms"
echo "3. robots.txt: ${robots_txt:-Not found}"
echo "4. Port 80 status: $port_80_status"
echo "   Port 443 status: $port_443_status"
echo "   Port 21 status: $port_21_status"

