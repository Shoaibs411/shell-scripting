#!/bin/bash
COMPONENT=mysql
COMPONENT_URL="https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo"
source component/common.sh

echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t   ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"

echo -e -n "\nConfiguring ${COMPONENT} repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo
status $?

echo -n "Installing ${COMPONENT} :"
yum install mysql-community-server -y &>> $LOGFILE
status $?

echo -n "Starting ${COMPONENT} :"
systemctl enable mysqld 
systemctl start mysqld
status $?

echo -n "Extracting ${COMPONENT} Default root Password :"
DEFAULT_ROOT_PASS=$(sudo grep "temporary password" /var/log/mysqld.log | awk -F " " '{print $NF}')
echo -n "Printing Default root pw : " $DEFAULT_ROOT_PASS
status $?




echo -e -n "\n     ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e -n "\n|--------------------------------------------------------------|\n"

