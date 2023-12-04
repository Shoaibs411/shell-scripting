$!/bin/bash

# Explroing redirectors in Shell

echo -e "\n|--------------------------------------------------------------------|"
echo -e "\n\t\e[35m \033[1m \033[3m Exploring Redirectos in Shell Scripting \033[0m \033[0m \e[0m"

# Redirectors are of 2 types in bash :
#     1) Input Redictor     ( < )        -  We use this to take input from a  file   :    <   ( Ex : sudo mysql </tmp/studentapp.sql )
#     2) Output Redirector  ( >> or > )( Means routing the output to a file )        :    > or 1>  or >>  or  &>  ( >> appends the latest output to the existing content)


# Outputs 
#     1) Standard Output                       1> or > or >>
#     2) Standard Error                        2> or 2>>
#     3) Standard Output and Standard Error    &> or &>>

# ls -ltr    >  output.txt   # Redirects the output to  output.txt
# ls -ltr    >> output.txt   # Redirects and appends the output to  output.txt
# ls -ltr    2> output.txt   # Redirects the error only to  output.txt
# ls -ltr    &> output.txt   # Redirects the output or error output.txt

echo -e "\n|--------------------------------------------------------------------|"