#!/bin/bash


# exploring dynamic variables in shell scripting.

#DATE=21/05/2023

DATE=$(date +%F)
no_of_sessions=$(who| wc -l)
echo -e "\n  Good Morning, Today's date is \e[32m $DATE \e[0m"


echo -e "\n  number of active users in system are \e[33m $no_of_sessions \e[0m"