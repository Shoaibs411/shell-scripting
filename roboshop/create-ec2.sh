#!/bin/bash

# This script is going create EC2 servers on AWS.
COMPONENT=$1
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=Linux Training" | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
INSTANCE_TYPE="t2.micro"

echo -e "\n|--------------------------------------------------------------|"
echo -e "\n\t ********** \e[35m \033[1m Server Creation in progress \033[0m \e[0m **********"

aws ec2 run-instances --image-id ${AMI_ID} --instace-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}}]"
