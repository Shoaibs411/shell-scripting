#!/bin/bash

# Exploring If-Else in Shell

echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n \e[35m \033[1m \t Exploring if-else in Shell Scripting \033[0m \e[0m"
echo -e "\n|--------------------------------------------------------------------|"

<<COMMENT
if condition is ideally available in 3 formats :
    1) Simple If 
    2) If Else 
    3) Else If  


1) Simple If :  

    if [ expression ]; then
            commands
    fi 

    Commands are going to be executed only if the expression is true. 

* What will happen if the expression  or false  ? Simple, commands won't be executed.


2) If-Else 

    if [ expression ]; then 

        command 1
    
    else    

        command 2

    fi 
 

* If expresssion is true, then command-1 will be executed. If the expression is not true, the command-2 will not be executed.


3) Else-If 

    if [ expression1 ] ; then
        
        command 1 

    elif [ expression2 ] ; then 

        command 2 
    
    elif [ expression3 ] ; then 

        command 3 
    
    else 
        
        command 4

    fi 

COMMENT
