#!/bin/bash

docker build -t codebuild-go-test .  && docker run --privileged codebuild-go-test
#docker/golang --storage-driver=overlay

