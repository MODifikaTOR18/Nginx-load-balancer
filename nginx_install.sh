sudo apt-get update
sudo apt-get install -y nginx

sudo rm /etc/nginx/sites-enabled/default
sudo cp ./nginx_load_balancer.conf /etc/nginx/conf.d/
sudo nginx -t
sudo systemctl restart nginx
