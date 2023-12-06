#!/bin/bash

LOGFILE="/tmp/${COMPONENT}.log"
APPUSER="roboshop"
COMPONENT_URL="https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
APPUSER_HOME="/home/$APPUSER/${COMPONENT}"

USERID=$(id -u)
if [ $UID -ne 0 ]; then
    echo -e "\n\e[31m \033[1m This script is expected to be executed with sudo or as a root user \033[0m \e[0m"
    echo -e "\n\t\e[35m Example Usage : sudo bash scriptName componentName \e[0m"
    exit 1
fi

status(){
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else    
        echo -e "\e[31m Failed \e[0m"
    fi
}

CREATE_USER(){

    echo -e -n "Creating ${APPUSER} user :"
    id $APPUSER                &>> LOGFILE
    if [ $? -ne 0 ]; then
        useradd $APPUSER
        status $?
    else 
        echo -e -n "\e[35m ${APPUSER} user already exist \e[0m"
    fi

}

DOWNLOAD_AND_EXTRACT(){

    echo -e -n "\nDownloading the $COMPONENT :"
    curl -s -L -o /tmp/${COMPONENT}.zip $COMPONENT_URL
    status $?

    echo -n "Performing Clean-up of ${COMPONENT} :"
    rm -rf $APPUSER_HOME            &>> LOGFILE
    status $?

    echo -e -n "Extracting ${COMPONENT} :"
    cd /home/$APPUSER
    unzip -o /tmp/${COMPONENT}.zip  &>> LOGFILE
    mv /home/${APPUSER}/${COMPONENT}-main /home/${APPUSER}/${COMPONENT}
    status $?

}

CONFIG_SVC(){

    echo -e -n "Configuring the ${COMPONENT} permissions :"
    # ${APPUSER_HOME}-main $APPUSER_HOME      
    chown -R $APPUSER:$APPUSER $APPUSER_HOME
    chmod -R 770 $APPUSER_HOME
    status $?

    echo -n "Configuring the ${COMPONENT} systemd file :"
    sed -i -e 's/USERHOST/user.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' ${APPUSER_HOME}/systemd.service


    mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
    status $?

}

START_SVC(){

    echo -n "Starting the ${COMPONENT} service :"
    systemctl daemon reload         &>> LOGFILE
    systemctl enable ${COMPONENT}   &>> LOGFILE
    systemctl start ${COMPONENT}   &>> LOGFILE
    status $?

}

NODEJS(){

    echo -e -n "\nConfiguring Latest Nodejs repo :"
    yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>> $LOGFILE || true
    status $?

    echo -e -n "Installing Nodejs :"
    yum install nodejs -y       &>> LOGFILE
    status $? 
    
    CREATE_USER         #Calling user function, which creates user.
    
    DOWNLOAD_AND_EXTRACT

    CONFIG_SVC

    echo -e -n "Generating the ${COMPONENT} Artifacts :"
    cd $APPUSER_HOME
    npm install     &>> LOGFILE
    status $?

    START_SVC

}

MAVEN(){

echo -e -n "\nInstalling Maven :"
    yum install maven -y  &>> $LOGFILE
    status $? 

    CREATE_USER         # calls create user function that creates user

    DOWNLOAD_AND_EXTRACT

    echo -n "Generating Artifacts :"
    cd $APPUSER_HOME 
    mvn clean package  &>> $LOGFILE
    mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar
    status $?

    CONFIG_SVC
    
    START_SVC

}

PYTHON(){

    echo -e -n "\nInstalling Python :"
    yum install python36 gcc python3-devel -y  &>> $LOGFILE
    status $? 

    CREATE_USER         # calls create user function that creates user

    DOWNLOAD_AND_EXTRACT

    echo -n "Generating Artifacts :"
    cd $APPUSER_HOME 
    pip3 install -r requirements.txt  &>> $LOGFILE
    status $?

    CONFIG_SVC

    USERID=$(id -u roboshop)
    GROUPID=$(id -g roboshop)

    echo "Updating the uid and gid of the ${COMPONENT}.ini file"
    sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c uid=${GROUPID}"  "${APPUSER_HOME}/${COMPONENT}.ini"
    
    START_SVC

}