#!/bin/bash

if [ -z "$1"  ]; then
    echo -e "\e[1;31mInput is missing\e[0m"
    exit 1
fi
COMPONENT=$1



TEMP_ID="lt-06e98f843b7024a45"
TEMP_VER=5

# check if instance is already there
aws ec2 describe-instances --filters "Name=tag:Name,Values=${COMPONENT}" | jq .Reservations[].Instances[].State.Name | sed 's/"//g' | grep -E 'running|stopped' &>/dev/null
if [ $? -eq 0 ]; then
  echo "Instance is already there"
  exit
fi
#create spot instance from launch template
aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${COMPONENT}}]" | jq

# update the DNS record


