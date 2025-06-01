#!/bin/bash

echo "--------------- STOPPING OLD CONTAINER -----------------"

docker stop TalkPick_Server || true
docker rm TalkPick_Server || true

echo "--------------- CONTAINER STOPPED -----------------"
