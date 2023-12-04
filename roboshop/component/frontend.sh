#!/bin/bash

echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Configuring frontend \033[0m \e[0m **********"

echo -e "\n\t \e[32m \033[1m Installing nginx \033[0m \e[0m "

yum install nginx -y
# systemctl enable nginx
# systemctl start nginx

# curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf


echo -e "\n|--------------------------------------------------------------------|"
