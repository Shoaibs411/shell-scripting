#!/bin/bash
UID=$(id -u)

if [ $UID -ne 0 ]; then
    echo -e "\n\e[31m \033[1m This script is expected to be executed with sudo or as a root user \033[0m \e[0m"
    echo -e "\n\t\e[35m Example Usage : sudo bash scriptName componentName \e[0m"
    exit 1
fi
echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Configuring frontend \033[0m \e[0m **********"

echo -e -n "\n Installing nginx :"

yum install nginx -y    &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
    echo -e "\e[32m Successfully Installed \e[0m"
else    
    echo -e "\e[31m Installation Failed \e[0m"

fi


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
