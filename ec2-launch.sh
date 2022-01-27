#!/bin/bash

TEMP_ID="lt-06e98f843b7024a45"
TEMP_VER=5

# check if instance is already there
aws ec2 run-instances --launch-template LaunchTemplateId=${TEMP_ID},Version=${TEMP_VER}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=frontend}]" "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=front}]" | jq

# update the DNS record


