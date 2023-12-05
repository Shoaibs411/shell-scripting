#!/bin/bash
COMPONENT=user

source component/common.sh
echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t   ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"


echo -e -n "\nConfiguring Nodejs repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -    &>> $LOGFILE
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>> $LOGFILE || true
status $?


echo -e -n "Installing Nodejs :"
yum install nodejs -y       &>> LOGFILE
status $?                   

echo -e -n "Creating ${APPUSER} user :"
id $APPUSER                &>> LOGFILE
if [ $? -ne 0 ]; then
    useradd $APPUSER
    status $?
else 
    echo -e -n "\e[35m ${APPUSER} user already exist \e[0m"
fi

echo -e -n "\nDownloading the $COMPONENT :"
curl -s -L -o /tmp/${COMPONENT}.zip $COMPONENT_URL
status $?

echo -n "Performing Clean-up of ${COMPONENT} :"
rm -rf $APPUSER_HOME        &>> LOGFILE
status $?

echo -e -n "Extracting ${COMPONENT} :"
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip      &>> LOGFILE
status $?

echo -e -n "Configuring the ${COMPONENT} permissions :"
mv ${APPUSER_HOME}-main $APPUSER_HOME      
chown -R $APPUSER:$APPUSER $APPUSER_HOME
chmod -R 770 $APPUSER_HOME
status $?

echo -e -n "Generating the ${COMPONENT} Artifacts :"
cd $APPUSER_HOME
npm install     &>> LOGFILE
status $?
echo -n "Configuring the ${COMPONENT} systemd file :"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' ${APPUSER_HOME}/systemd.service
sed -i -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' ${APPUSER_HOME}/systemd.service
mv ${APPUSER_HOME}/systemd.service /etc/systemd/system/${COMPONENT}.service
status $?

echo -n "Starting the ${COMPONENT} service :"
systemctl daemon reload         &>> LOGFILE
systemctl enable ${COMPONENT}   &>> LOGFILE
systemctl start ${COMPONENT}   &>> LOGFILE
status $?


echo -e -n "\n     ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e -n "\n|--------------------------------------------------------------|\n"
