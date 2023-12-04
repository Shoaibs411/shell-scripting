#!/bin/bash

# Exploring Conditions in Shell

echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n\t\e[35m \033[1m \033[3m Exploring Conditions in Shell Scripting \033[0m \033[0m \e[0m"

ACTION=$1

case $ACTION in
    start)
        echo -e "\n\te[33m \033[1m \033[3mStarting Shipping Services\033[0m \033[0m \e[0m"
        exit 0
        ;;

    stop)
        echo -e "\n\te[31m \033[1m \033[3mStopping Shipping Services\033[0m \033[0m \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\n\te[32m \033[1m \033[3mStopping Shipping Services\033[0m \033[0m \e[0m"
        exit 1
        ;;
    *)
        echo -e "\n\te[32m \033[1m \033[3mValid options are as follows :-s\033[0m \033[0m \e[0m"
        echo -e "\n\t 1.Start \n\t 2. stop \n\t 3.restart"
        exit 2
        ;;


esac

echo -e "\n|--------------------------------------------------------------------|"

