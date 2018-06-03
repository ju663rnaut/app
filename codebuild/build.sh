#!/bin/bash

set -e

docker build -t codebuild-go-test .
docker tag codebuild-go-test:latest 692551067032.dkr.ecr.eu-central-1.amazonaws.com/codebuild-go-test:latest
docker push 692551067032.dkr.ecr.eu-central-1.amazonaws.com/codebuild-go-test:latest

