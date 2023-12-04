#!/bin/bash
USERID=$(id -u)
COMPONENT=$1

status(
    if [ $? -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else    
        echo -e "\e[31m Failed \e[0m"
    fi
)

if [ $UID -ne 0 ]; then
    echo -e "\n\e[31m \033[1m This script is expected to be executed with sudo or as a root user \033[0m \e[0m"
    echo -e "\n\t\e[35m Example Usage : sudo bash scriptName componentName \e[0m"
    exit 1
fi
echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Configuring #COMPONENT \033[0m \e[0m **********"

echo -e -n "\nInstalling nginx :"

yum install nginx -y    &>> /tmp/frontend.log
status $?

echo -e -n "Downloading the $COMPONENT :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
status $?

echo -e -n "Clean-up of $COMPONENT :"
cd /usr/share/nginx/html
rm -rf *                        &>> /tmp/frontend.log
status $?

echo -e -n "Extracting $COMPONENT :"
unzip /tmp/frontend.zip         &>> /tmp/frontend.log
status $?

echo -e -n "Configuring $COMPONENT :"
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
status $?

echo -e -n "Restarting $COMPONENT :"
systemctl enable nginx      &>> /tmp/frontend.log
systemctl daemon reload     &>> /tmp/frontend.log
systemctl start nginx       &>> /tmp/frontend.log
status $?

echo -e "\n\t ********** \e[35m \033[1m Frontend Configured Successsfully \033[0m \e[0m **********"

echo -e "\n|--------------------------------------------------------------|"
