#!/bin/bash
USERID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO=https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo

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

echo -e -n "Downloading the $COMPONENT repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGO_REPO
status $?

echo -e -n "Installing the $COMPONENT :"
um install -y mongodb-org    &>> ${LOGFILE}
status $?

# systemctl enable mongod
# systemctl start mongod
