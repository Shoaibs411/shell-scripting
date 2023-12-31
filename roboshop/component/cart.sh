#!/bin/bash
COMPONENT=cart


echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t   ********** \e[35m \033[1m Configuring ${COMPONENT} \033[0m \e[0m **********"

source component/common.sh
    
NODEJS      # Calling the NodeJS function to install & configure NodeJS

echo -e -n "\n     ********** \e[35m \033[1m ${COMPONENT} Configuration Completed \033[0m \e[0m **********"
echo -e -n "\n|--------------------------------------------------------------|\n"
