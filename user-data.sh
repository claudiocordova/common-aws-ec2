#!/bin/bash
# Install Docker
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 361494667617.dkr.ecr.us-east-1.amazonaws.com/poker-analyzer-service-repository
docker pull 361494667617.dkr.ecr.us-east-1.amazonaws.com/poker-analyzer-service-repository:0.0.1-SNAPSHOT
docker run -p 8080:8080 361494667617.dkr.ecr.us-east-1.amazonaws.com/poker-analyzer-service-repository:0.0.1-SNAPSHOT > /home/ec2-user/app.log