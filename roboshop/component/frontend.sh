#!/bin/bash
USERID=$(id -u)
COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.log"

status(){
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else    
        echo -e "\e[31m Failed \e[0m"
    fi
}

if [ $UID -ne 0 ]; then
    echo -e "\n\e[31m \033[1m This script is expected to be executed with sudo or as a root user \033[0m \e[0m"
    echo -e "\n\t\e[35m Example Usage : sudo bash scriptName componentName \e[0m"
    exit 1
fi
echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"

echo -e -n "\nInstalling Nginx :"
yum install nginx -y    &>> $LOGFILE
status $?

echo -e -n "Downloading the $COMPONENT :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
status $?

echo -e -n "Clean-up of ${COMPONENT} :"
cd /usr/share/nginx/html
rm -rf *                        &>> $LOGFILE
status $?

echo -e -n "Extracting ${COMPONENT} :"
unzip -o /tmp/${COMPONENT}.zip        &>> $LOGFILE
status $?

echo -e -n "Configuring ${COMPONENT} :"
mv ${COMPONENT}-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
status $?

echo -n "Updating Reverse-Proxy :"
    for component in catalogue user cart; do 
        sed -i -e "/${component}/s/localhost/${component}.roboshop.internal/" /etc/nginx/default.d/roboshop.conf
    done 
status $?

echo -e -n "Restarting ${COMPONENT} :"
systemctl enable nginx     &>> $LOGFILE
systemctl daemon reload    &>> $LOGFILE
systemctl start nginx      &>> $LOGFILE
status $?

echo -e "\n   ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"

echo -e "\n|--------------------------------------------------------------|"
