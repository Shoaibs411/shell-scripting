#!/bin/bash
USERID=$(id -u)
COMPONENT=redis
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
echo -e "\n\t   ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"

echo -n "Configuring Repositories :"
curl -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/${COMPONENT}.repo -o /etc/yum.repos.d/${COMPONENT}.repo     &>> $LOGFILE  
status $?

echo -n "Installing ${COMPONENT} :"
yum install redis-6.2.13 -y     &>> $LOGFILE
status $?

echo -n "Starting the ${COMPONENT} service :"
systemctl daemon reload         &>> LOGFILE
systemctl enable ${COMPONENT}   &>> LOGFILE
systemctl start ${COMPONENT}   &>> LOGFILE
status $?


echo -e "\n     ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e "\n|--------------------------------------------------------------|"
