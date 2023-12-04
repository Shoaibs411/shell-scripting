#!/bin/bash

# Exploring Conditions in Shell

echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n \e[35m \033[1m \033[3m \t Exploring Conditions in Shell Scripting \033[0m \033[0m \e[0m"

ACTION=$1

case $ACTION in
    start)
        echo -e "\n \e[32m \033[1m \033[3m \t Starting Shipping Services\033[0m \033[0m \e[0m"
        echo -e "\n|--------------------------------------------------------------------|"

        exit 0
        ;;

    stop)
        echo -e "\n \e[31m \033[1m \033[3m \t Stopping Shipping Services\033[0m \033[0m \e[0m"        
        echo -e "\n|--------------------------------------------------------------------|"

        exit 1
        ;;
    restart)
        echo -e "\n \e[34m \033[1m \033[3m \t Restarting Shipping Services\033[0m \033[0m \e[0m"        
        echo -e "\n|--------------------------------------------------------------------|"

        exit 2
        ;;
    *)
        echo -e "\n \e[31m \033[1m \033[3m \t Valid options are as follows :-\033[0m \033[0m \e[0m"        
        echo -e "\n\t 1.Start \n\t 2.stop \n\t 3.restart"
        echo -e "\n \e[32m \033[1m \t Example usage :- 'bash scriptname.sh start' \033[0m \e[0m"        

        echo -e "\n|--------------------------------------------------------------------|"

        exit 3
        ;;


esac

echo -e "\n|--------------------------------------------------------------------|"

