#!/usr/bin/env bash
YLW='\033[0;33m'
GRN='\033[0;32m'
NC='\033[0m'
echo "Preparing to setup Nginx Load Balancer example..."

echo "Check if Docker is installed..."
if [ -x "$(command -v docker)" ]; then
    echo -e "${GRN}Docker is already installed${NC}"
else
    echo -e "${YLW}Docker is not installed on this machine. Installing...${NC}"
    bash docker_install.sh
fi

echo "Start up Nginx containers"
sudo docker compose up -d

echo "Check if Nginx is installed..."
if [ -x "$(command -v nginx)" ]; then
    echo -e "${GRN}Nginx is already installed${NC}"
else
    echo -e "${YLW}Nginx is not installed on this machine. Installing...${NC}"
    bash nginx_install.sh
fi

while true; do

    read -p "Patch /etc/hosts file to enable server_name available? (y/n)" answer
    case $answer in
        [Yy] ) echo "Patching /etc/hosts file...";
            sudo bash -c 'echo "127.0.0.1       load-balancer.example.com" >> /etc/hosts';
            echo -e "${GRN}Done! You can test load balancer by curl'ing load-balancer.example.com and tail'ing /var/log/nginx/access.log!${NC}";
            break;;
        [Nn] ) echo -e "${GRN}Then installation is done! You can test load balancer by curl'ing localhost and tail'ing /var/log/nginx/access.log!${NC}";
            break;;
        * ) echo "Invalid response";;
    esac
done
