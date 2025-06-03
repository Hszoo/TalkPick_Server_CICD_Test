#!/bin/bash

echo "--------------- STARTING NEW CONTAINER -----------------"

# ECR 로그인
aws ecr get-login-password --region ap-northeast-2 \
  | docker login --username AWS --password-stdin 536697254327.dkr.ecr.ap-northeast-2.amazonaws.com

# 이미지 Pull
docker pull 536697254327.dkr.ecr.ap-northeast-2.amazonaws.com/talkpick-server:latest

# 이전 컨테이너 삭제 (선택 사항)
docker rm -f TalkPick_Server || true

# 새 컨테이너 실행
docker run -d \
  --name TalkPick_Server \
  -p 8080:8080 \
  --env-file /home/ubuntu/TalkPick_Server_CICD_Test/.env \
  536697254327.dkr.ecr.ap-northeast-2.amazonaws.com/talkpick-server:latest

echo "--------------- CONTAINER STARTED -----------------"
