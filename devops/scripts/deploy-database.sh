#!/bin/bash
check_sucessful(){
    if [ $? != 0 ];
    then
        echo "Error Execution"
        exit 1
    fi
}

login() {
    aws ecr get-login-password --region ${AWS_REGION} | \
        docker login --username AWS --password-stdin ${AWS_ACCOUNT_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com
}

deploy() {
    docker run \
        -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
        -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
        -e AWS_REGION="${AWS_REGION}" \
        -e REMOTE_STATE_BUCKET="${REMOTE_STATE_BUCKET}" \
        -e REMOTE_STATE_FILE="${REMOTE_STATE_FILE}" \
        -e REMOTE_STATE_AWS_REGION="${REMOTE_STATE_AWS_REGION}" \
        -e ENV="${ENV}" \
        -e ENV_VERSION="${ENV_VERSION}" \
        -e PRODUCT="${PRODUCT}" \
        -e CREATED_BY="${CREATED_BY}" \
        -e OWNER="${OWNER}" \
        -e PROJECT="${PROJECT_NAME}" \
        -e ROLE="${ROLE}" \
        -e ENGINE="${ENGINE}" \
        -e ENGINE_VERSION="${ENGINE_VERSION}" \
        -e DATABASE_NAME="${DATABASE_NAME}" \
        -e DATABASE_USERNAME="${DATABASE_USERNAME}" \
        -e BACKUP_RETENTION_PERIOD="${BACKUP_RETENTION_PERIOD}" \
        -e STORAGE_ENCRYPTED="${STORAGE_ENCRYPTED}" \
        -e DELETION_PROTECTION="${DELETION_PROTECTION}" \
        -e ENGINE_MODE="${ENGINE_MODE}" \
        -e SKIP_FINAL_SNAPSHOT="${SKIP_FINAL_SNAPSHOT}" \
        -e COPY_TAGS_TO_SNAPSHOT="${COPY_TAGS_TO_SNAPSHOT}" \
        -e AUTO_PAUSE="${AUTO_PAUSE}" \
        -e MAX_CAPACITY="${MAX_CAPACITY}" \
        -e MIN_CAPACITY="${MIN_CAPACITY}" \
        -e SECONDS_UNTIL_AUTO_PAUSE="${SECONDS_UNTIL_AUTO_PAUSE}" \
        -e TIMEOUT_ACTION="${TIMEOUT_ACTION}" \
        ${AWS_ACCOUNT_REGISTRY}.dkr.ecr.${AWS_REGION}.amazonaws.com/iac-aws-rds-serverless:1.0.6-deploy

}

AWS_ACCOUNT_REGISTRY=$(aws sts get-caller-identity --output text |awk '{print $1}')
    check_sucessful

login
    check_sucessful

deploy
    check_sucessful