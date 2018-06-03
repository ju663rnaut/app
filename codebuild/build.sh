#!/bin/bash

set -e

if [ -z "$ECR_REPO_URI" ]; then
    echo "environment variable 'ECR_REPO_URI' not set"
    exit 1
fi

if ! [[ ${ECR_REPO_URI} =~ ^[0-9]{12}\.dkr.ecr.[a-z0-9\-]+.amazonaws.com/[a-z\-]+$ ]]; then
    echo "environment variable 'ECR_REPO_URI' has invalid format"
	exit 1
fi

docker build -t codebuild-go-test .
docker tag codebuild-go-test:latest ${ECR_REPO_URI}:latest
docker push ${ECR_REPO_URI}:latest
