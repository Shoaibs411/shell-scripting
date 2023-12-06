#!/bin/bash
COMPONENT=rabbitmq


echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"

source component/common.sh
    
echo -e "\nConfiguring ${COMPONENT} repo :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash    &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash   &>> $LOGFILE
status $?

echo -n "Installing ${COMPONENT} :"
yum install rabbitmq-server -y &>> $LOGFILE
status $?

echo -n "Starting $COMPONENT Service :"
systemctl enable rabbitmq-server       &>> $LOGFILE
systemctl start rabbitmq-server        &>> $LOGFILE
status $? 

rabbitmqctl list_users | grep ${APPUSER} &>> $LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Creating $APPUSER for $COMPONENT: "
    rabbitmqctl add_user roboshop roboshop123  &>> $LOGFILE
    status $? 
fi

echo -n "Sorting Permissions :"
rabbitmqctl set_user_tags roboshop administrator       &>> $LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"     &>> $LOGFILE
status $?

echo -e "\n   ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e "\n|--------------------------------------------------------------|\n"
