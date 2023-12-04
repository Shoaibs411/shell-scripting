#!/bin/bash

# Exploring if-else in Shell Scripting


echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n \e[35m \033[1m \t Exploring If, If Else & Else If in Shell Scripting \033[0m \e[0m"

ACTION=$1

if [ "$ACTION" == "start" ] ; then
        echo -e "\n \e[32m \033[1m \033[3m \t Starting Shipping Services\033[0m \033[0m \e[0m"
        echo -e "\n|--------------------------------------------------------------------|"
        exit 0
elif [ "$ACTION" == "stop" ] ; then
        echo -e "\n \e[31m \033[1m \033[3m \t Stopping Shipping Services\033[0m \033[0m \e[0m"
        echo -e "\n|--------------------------------------------------------------------|"
        exit 1
elif [ "$ACTION" == "restart" ] ; then
        echo -e "\n \e[33m \033[1m \t Restarting Shipping Services \033[0m \e[0m"
        echo -e "\n|--------------------------------------------------------------------|"
        exit 2
          
fi

        echo -e "\n \e[31m \033[1m \t It has not met any conditions \033[0m \e[0m"
        echo -e "\n \e[31m \033[1m \t Valid options are as follows \033[0m \e[0m"
        echo -e "\n\t 1.start \n\t 2.stop \n\t 3.restart"
        echo -e "\n \e[32m \033[1m \t Example usage :- 'bash scriptname.sh start' \033[0m \e[0m" 

        echo -e "\n|--------------------------------------------------------------------|"
        exit 100