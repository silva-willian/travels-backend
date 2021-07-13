#!/bin/bash
check_sucessful(){
    if [ $? != 0 ];
    then
        echo "Error Execution"
        exit 1
    fi
}

login() {
    aws ecr get-login-password --region ${AWS_REGION} --profile ${AWS_PROFILE} | \
        docker login --username AWS --password-stdin ${AWS_ACCOUNT_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com
}

build_push() {
    docker build -t ${PROJECT_NAME}:${VERSION} -f devops/application/build/Dockerfile .
        check_sucessful

    docker tag ${PROJECT_NAME}:${VERSION} ${AWS_ACCOUNT_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com/${PROJECT_NAME}:${VERSION}
        check_sucessful

    docker push ${AWS_ACCOUNT_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com/${PROJECT_NAME}:${VERSION}
        check_sucessful

    docker rmi ${AWS_ACCOUNT_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com/${PROJECT_NAME}:${VERSION}
        check_sucessful

    docker rmi ${PROJECT_NAME}:${VERSION}
        check_sucessful
}

AWS_ACCOUNT_REGISTRY=$(aws sts get-caller-identity --output text --profile ${AWS_PROFILE} |awk '{print $1}')
    check_sucessful

VERSION="1.0.${GITHUB_RUN_NUMBER}"

login
    check_sucessful

build_push
    check_sucessful