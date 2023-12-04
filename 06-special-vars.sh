#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

echo -e "\n \e[33m "${bold}" Exploring Special variables in Shell Scripting \e[0m "${normal}""

echo -e "\n" '$0' "Prints Script Name : \e[34m $0 \e[0m"
echo -e "\n" '$#' "Prints the overall arguments used in the script : \e[34m $# \e[0m"
echo -e "\n" '$?' "prints the exit code of the last command : \e[34m $? \e[0m"
echo -e "\n" '$*' "Prints all the arguments used. : \e[34m $* \e[0m"
echo -e "\n" '$@' "Prints all the arguments used. : \e[34m $@ \e[0m"

echo -e '\033[1mSample\033[0m'

# echo "Variables Used In The Script $*"    # $* is going to print the used variables  
# echo "Variabels used are $@"              # $@ is going to print the used variables  