#!/bin/bash

# Exploring Functions in Bash
echo -e "\n \e[35m \033[1m \033[3m "${bold}" Exploring Funtions in Shell Scripting \033[0m \033[0m \e[0m "${normal}""

# There are 4 types of command available : 

# 1) Binary                   ( /bin  , /sbin )
# 2) Aliases                  ( Alises are shortcuts,  alias net="netstat -tulpn" )
# 3) Shell Built-in Commands  
# 4) Functions                # Functions are nothing but a set of command that can be written in a sequence and can be called n number of times as per your choice.

# How to declare a function ?


b56() {

    echo -e "\n This is inside a function b56"
}

b56
echo -e "\n Called out the function b56" 

stat() {

    echo "Number of sessions opened $(who|wc -l)"
    echo "Todays date is $(date +%F)"
    echo "AVG Cpu Utilization In The Last 5 minues is : $(uptime|awk -F : '{print $NF}' | awk -F ',' '{print $2}')"

    b56  # calling a function from another function
}

stat 