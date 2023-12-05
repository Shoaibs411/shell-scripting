#!/bin/bash
USERID=$(id -u)
COMPONENT=mongo
LOGFILE="/tmp/${COMPONENT}.log"
MONGO_REPO="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"
SCHEMA_URL="https://github.com/stans-robot-project/mongodb/archive/main.zip"

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
yum install -y mongodb-org    &>> ${LOGFILE}
status $?


echo -e -n "Enabling $COMPONENT visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status $?

echo -e -n "Starting ${COMPONENT} :"
systemctl enable mongod     &>> $LOGFILE
systemctl daemon reload    &>> $LOGFILE
systemctl start mongod      &>> $LOGFILE
status $?


echo -e -n "Downloading ${COMPONENT} Schema :"


curl -s -L -o /tmp/mongodb.zip $SCHEMA_URL
status $?

echo -e -n "Extracting the ${COMPONENT} :"
cd /tmp/
unzip -o mongodb.zip     &>> $LOGFILE
status $?

echo -e -n "Injecting ${COMPONENT} Schema :"
cd /tmp/mongodb-main
mongo < catalogue.js
mongo < users.js
status $?

echo -e "\n|--------------------------------------------------------------|"







# systemctl enable mongod
# systemctl start mongod
