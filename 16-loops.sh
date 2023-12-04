#!/bin/bash

# Exploring Loops in Shell scripting.


echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n \e[35m \033[1m \t Exploring Loops in Shell Scripting \033[0m \e[0m"

# Loops : When you want to run an action for certain number of times, we use loops.

# There are 2 major types of loops ; 
#     1) For loop       ( When you know something to be executed n number of time, we use for loop)
#     2) While loop     ( When you don't know something to be executed n number of times, we use while loop)

# echo Value is 10
# echo Value is 20 
# echo Value is 30
# echo Value is 40
# echo Value is 50 

for i in 10 20 30 40 50 ; do 
echo -e "\n \e[32m \t Values from the loop are $i \e[0m"
done 

<<COMMENT

for name in Jethalal Popatlal Sundarlal Manilal Mohanlal ; do
echo -e "\n \e[33m \t Names from the loop are $name \e[0m"
done

COMMENT

echo -e "\n|--------------------------------------------------------------------|"

for cmd_arg in $@ ; do
echo -e "\n \e[34m \t Command line arguments are $cmd_arg \e[0m"
done