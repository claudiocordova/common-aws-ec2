#!/bin/bash

REGION=$(aws configure get region)

if [ -z "$1" ]; then
      MODE=EC2
elif [ "$1" == "EC2" ]; then
      MODE=$1
elif [ "$1" == "EC2_DOCKER" ]; then
      MODE=$1
else
    echo "Wrong parameter 1 MODE: "$1
    exit 1 
fi


if [ "$MODE" == "EC2" ]; then
  aws cloudformation create-stack --region $REGION  --stack-name ec2-elb-asg-stack --template-body file://./ec2-elb-asg.yaml --capabilities CAPABILITY_IAM
  result=$?
elif [ "$MODE" == "EC2_DOCKER" ]; then
  aws cloudformation create-stack --region $REGION  --stack-name ec2-elb-asg-stack --template-body file://./ec2-elb-asg-docker.yaml --capabilities CAPABILITY_IAM
  result=$?
fi

if [ $result -eq 254 ] || [ $result -eq 255 ]; then
  echo "ec2-elb-asg-stack already exists"
  #exit 0
elif [ $result -ne 0 ]; then
  echo "ec2-elb-asg-stack failed to create " $result
  exit 1
fi

aws cloudformation wait stack-create-complete --region $REGION --stack-name ec2-elb-asg-stack




