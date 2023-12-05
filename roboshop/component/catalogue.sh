#!/bin/bash
COMPONENT=catalogue
USERID=$(id -u)
LOGFILE="/tmp/${COMPONENT}.log"
APP_USER="roboshop"

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

<<comment
echo -e -n "Configuring Nodejs repo"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -    &>> $LOGFILE
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>> $LOGFILE || true
status $?
comment

echo -e -n "Installing Nodejs"
yum install nodejs -y       &>> LOGFILE
status $?                   

echo -e -n "Creating ${APP_USER} user :"
id $APP_USER                &>> LOGFILE
if [ $? -ne 0 ]; then
    useradd $APP_USER
    status $?
else 
    echo -e -n "\e[31m ${APP_USER} user already exist \e[0m"
fi

echo -e -n "\n\n    ********** \e[35m \033[1m Configuring ${COMPONENT} completed \033[0m \e[0m **********"
echo -e -n "\n|--------------------------------------------------------------|"
