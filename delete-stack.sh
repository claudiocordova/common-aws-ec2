#!/bin/bash

REGION=$(aws configure get region)

aws cloudformation delete-stack --region $REGION --stack-name ec2-elb-asg-stack

if [ $? -ne 0 ]; then
  echo "Failed to delete ec2-elb-asg-stack"
  exit 1
fi

aws cloudformation wait stack-delete-complete --region $REGION --stack-name ec2-elb-asg-stack
