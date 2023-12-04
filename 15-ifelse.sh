#!/bin/bash

# Exploring if-else in Shell Scripting


echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n \e[35m \033[1m \t Exploring If, If Else & Else If in Shell Scripting \033[0m \e[0m"
echo -e "\n|--------------------------------------------------------------------|"

$ACTION=$1

if [ "$ACTION" == "start" ] ; then
        echo -e "\n \e[32m \033[1m \033[3m \t Starting Shipping Services\033[0m \033[0m \e[0m"
        echo -e "\n|--------------------------------------------------------------------|"
        exit 0
fi