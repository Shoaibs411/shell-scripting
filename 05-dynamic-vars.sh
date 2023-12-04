#!/bin/bash


# exploring dynamic variables in shell scripting.

#DATE=21/05/2023

DATE=$(date +%F)
no_of_sessions=$(who| wc -l)
echo -e "\n \e[32m Good Morning, Today's date is $DATE \e[0m"


echo -e "\n \e[32m number of active users in system are $no_of_sessions \e[0m"