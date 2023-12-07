#!/bin/bash 

# This script is going to create EC2 Servers

if [ -z $1 ] || [ -z $2 ] ; then 
    echo -e "\e[31m ****** COMPONENT NAME & ENV ARE NEEDED ****** \e[0m \n\t\t"
    echo -e "\e[36m \t\t Example Usage : \e[0m  bash create-ec2 ratings dev"
    exit 1 
fi 

COMPONENT=$1
ENV=$2
#HOSTEDZONEID="Z08445993T3OQ7PISU2JV"  hardcoding is not good if hosted zone id got updated.
HOSTEDZONEID=$(aws route53 list-hosted-zones | jq '.HostedZones[] | select(.Name == "roboshop.internal.") | .Id' | sed -e 's/hostedzone//g' -e 's|/||g' -e 's|"||g')
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq ".Images[].ImageId" | sed -e 's/"//g')
SGID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=b56-allow-all" | jq ".SecurityGroups[].GroupId" | sed -e 's/"//g')
INSTANCE_TYPE="t2.micro"

create_server() {
    echo -e "******* \e[32m $COMPONENT-$ENV \e[0m Server Creation In Progress ******* !!!!!!"

    PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type ${INSTANCE_TYPE} --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq ".Instances[].PrivateIpAddress" | sed -e 's/"//g')
    echo -e "******* \e[32m $COMPONENT-$ENV \e[0m Server Creation Is Complted ******* !!!!!! \n\n"

    echo -e "******* \e[32m $COMPONENT-$ENV \e[0m DNS Record Creation In Progress ******* !!!!!!"
    sed -e "s/COMPONENT/${COMPONENT}-${ENV}/" -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json > /tmp/dns.json

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/dns.json\

    echo -e "******* \e[32m $COMPONENT-$ENV \e[0m DNS Record Creation Is Completed ******* !!!!!! \n\n"
}

# If the user supplies all as the first argument, then all these servers will be created.
if [ "$1" == "all" ]; then 

    for component in mongodb catalogue cart user shipping frontend payment mysql redis rabbitmq; do 
        COMPONENT=$component 
        create_server 
    done 

else 
    create_server 
fi 