#!/bin/bash

bash component/$1.sh

if [ $? -ne 0 ] ; then
    echo -e "\n|--------------------------------------------------------------------|"
    echo -e "\n \e[31m \033[1m \t Example usage : wrapper.sh componentName \033[0m \e[0m"
    echo -e "\n|--------------------------------------------------------------------|"
    exit 30
fi