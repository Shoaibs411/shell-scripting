#!/bin/bash
COMPONENT=shipping


echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"

source component/common.sh
    
MAVEN      # Calling the MAVEN function to install & configure JAVA

echo -e "\n   ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e "\n|--------------------------------------------------------------|\n"
