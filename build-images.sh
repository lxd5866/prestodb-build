#!/usr/bin/env bash


PRESTO_VERSION=$1


ls ./docker/presto-server-${PRESTO_VERSION}

if [ $? -eq 0 ] ;then
  echo "file exist ,skip download"
else
  echo "file not exist, download now"
  PRESTO_BIN=https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz
  cd ./docker  && wget ${PRESTO_BIN}
  tar -xf ./docker/presto-server-${PRESTO_VERSION}.tar.gz -C ./docker
  rm  -rf ./docker/presto-server-${PRESTO_VERSION}.tar.gz
fi


#判断基础继续是否存在
docker inspect jre-python:v1 -f '{{.Id}}' > /dev/null
if [ $? -eq 0 ] ;then
echo "docker exist ,skip build base image"
else
  exec ./pre-image.sh
fi

#构建镜像
cd docker && \
docker build -t deploy.deepexi.com/fastdata/prestodb:${PRESTO_VERSION} --build-arg "PRESTO_VERSION=${PRESTO_VERSION}" .
docker push deploy.deepexi.com/fastdata/prestodb:${PRESTO_VERSION}
