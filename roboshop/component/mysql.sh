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
status $?

echo "show databases;" | mysql -uroot -pRoboShop@1 &>> $LOGFILE
if [ $? -ne 0 ]; then 
    echo -n "Updating $COMPONENT root password:"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -p$DEFAULT_ROOT_PASS &>> $LOGFILE
    status $?
fi

echo "show plugins;" |  mysql -uroot -pRoboShop@1 | grep validate_password &>> $LOGFILE
if [ $? -eq 0 ]; then 
    echo -n "Uninstalling password-validate-plugin :"
    echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1 &>> $LOGFILE 
    status $?
fi

echo -e -n "\n     ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e -n "\n|--------------------------------------------------------------|\n"

