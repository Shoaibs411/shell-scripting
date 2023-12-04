#!/bin/bash

# Exploring Conditions in Shell

echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n\t \e[35m \033[1m \033[3m Exploring Conditions in Shell Scripting \033[0m \033[0m \e[0m"

ACTION=$1

case $ACTION in
    start)
        echo -e "\n\t \e[35m \033[1m \033[3m Starting Shipping Services\033[0m \033[0m \e[0m"
        echo -e "\n|--------------------------------------------------------------------|"

        exit 0
        ;;

    stop)
        echo -e "\n\t \e[35m \033[1m \033[3m Stopping Shipping Services\033[0m \033[0m \e[0m"        
        echo -e "\n|--------------------------------------------------------------------|"

        exit 1
        ;;
    restart)
        echo -e "\n\t \e[35m \033[1m \033[3m Restarting Shipping Services\033[0m \033[0m \e[0m"        
        echo -e "\n|--------------------------------------------------------------------|"

        exit 1
        ;;
    *)
        echo -e "\n\t \e[35m \033[1m \033[3m Valid options are as follows :-\033[0m \033[0m \e[0m"        
        echo -e "\n\t 1.Start \n\t 2.stop \n\t 3.restart"
        echo -e "\n|--------------------------------------------------------------------|"

        exit 2
        ;;


esac

echo -e "\n|--------------------------------------------------------------------|"

