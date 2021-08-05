#!/usr/bin/env bash

docker build -t deploy.deepexi.com/fastdata/jre-python:v1 -f docker/Dockerfile-pre .
docker push deploy.deepexi.com/fastdata/jre-python:v1