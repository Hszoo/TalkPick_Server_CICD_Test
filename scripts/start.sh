#!/bin/bash

echo "--------------- STARTING NEW CONTAINER -----------------"

# Pull latest image from ECR
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 536697254327.dkr.ecr.ap-northeast-2.amazonaws.com
docker pull 536697254327.dkr.ecr.ap-northeast-2.amazonaws.com/talkpick-server:latest

# Run new container
docker run -d \
  --name TalkPick_Server \
  -p 8080:8080 \
  --env-file /home/ubuntu/TalkPick_Server_CICD_Test/.env \
  536697254327.dkr.ecr.ap-northeast-2.amazonaws.com/talkpick-server:latest

echo "--------------- CONTAINER STARTED -----------------"
