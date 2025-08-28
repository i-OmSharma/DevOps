#!/bin/bash

#######################
# Author: Om Sharma
# Date: 29-08-2-25
# version: v1
# This script will report the AWS resouce usage
######################

######################
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM
#####################

set -x 
# S3 bucket listing
echo "S3 bucket lisitng"
aws s3 ls

# EC2 instance listing
echo "EC2 isntcne lisiting"
# aws ec2 describe-instaces
aws ec2 describe-instances | jq '.Reservation[].Instances[].InstanceId'
# Lambda listing
echo "Lambda Fucniton lisitng"
aws lambda list-funciton

# IAM users lisitng
echo " IAM user lsiting"
aws iam list-users

