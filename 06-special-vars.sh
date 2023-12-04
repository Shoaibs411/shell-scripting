#!/bin/bash

echo -e "\n \e[33m Exploring Special variables in Shell Scripting \e[0m"

echo -e "\nPrinting the Script Name : \e[34m $0 \e[0m"
echo -e "\nPrinting the 1st line Argument : \e[34m $1 \e[0m"
echo -e "\nPrinting the 2nd line Argument : \e[34m $2 \e[0m"



echo -e "\n '$0'Prints Script Name : \e[34m $0 \e[0m"
echo -e "\nPrinting all arguments used in script Name : \e[34m $# \e[0m"
echo -e "\nPrinting exit code of the previous command : \e[34m $? \e[0m"

echo $0   # Prints Script Name 
echo $#   # Prints the overall arguments used in the script 
echo $?   # This prints the exit code of the last command
echo $*   # Prints all the arguments used.
echo $@   # Prints all the arguments used.

# echo "Variables Used In The Script $*"    # $* is going to print the used variables  
# echo "Variabels used are $@"              # $@ is going to print the used variables  