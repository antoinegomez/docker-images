#!/usr/bin/env bash

set -e

# BEGIN CUSTOMIZATIONS #
ECS_REGION='eu-west-1'
ECS_CLUSTER_NAME="${AWS_ENV}-applications"
ECR_NAME=${APPLICATION_NAME}
ECR_URI="396131430019.dkr.ecr.eu-west-1.amazonaws.com/greenjinn/${APPLICATION_NAME}"
VERSION="${CI_BUILD_REF}"
AWSCLI_VER_TAR=1.16.263
# END CUSTOMIZATIONS #

# BEGIN OTHER VAR DEFINITIONS #
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
AWSCLI_VER=$(aws --version 2>&1 | cut -d ' ' -f 1 | cut -d '/' -f 2)
# END OTHER VAR DEFINITIONS #

if [[ ${AWSCLI_VER} < ${AWSCLI_VER_TAR} ]]
then echo "ERROR: Please upgrade your AWS CLI to version ${AWSCLI_VER_TAR} or later!"
  exit 1
fi

usage() {
  echo "Usage: $0 -e  [-b ]"
  echo "  must be either 'staging' or 'production'"
  echo "  must be a valid ref. If no branch is provided, you will be prompted for one."
  exit 1
}

(
  # Get ecs env variables from sysadmin bucket
  aws s3 cp s3://${AWS_SYSADMIN_BUCKET}/env/${AWS_ENV}/${APPLICATION_NAME}/ecs.env ecs.env
  source ecs.env

  # Generate .task.json file by describing task
  aws ecs --profile "${AWS_PROFILE}" describe-task-definition --region "${ECS_REGION}" --task-definition "${ECS_TASK_DEFINITION_NAME}" > src/.task.json

  # Generating new container definition
  NEW_CONTAINER_DEF="$(ECR_URI=${ECR_URI} ENV_FILE_PATH=${ENV_FILE_PATH} VERSION=${VERSION} AWS_ENV=${AWS_ENV} ECS_TASK_DEFINITION_NAME=${ECS_TASK_DEFINITION_NAME} node src/update-image.js)"

  # Generating volumes json
  VOLUMES="$(node ECS_VOLUME_NAME=${ECS_VOLUME_NAME} src/create-volumes-json.js)"
  echo ${VOLUMES}

  # Creating new task definition
  # aws ecs --profile "${AWS_PROFILE}" register-task-definition --region "${ECS_REGION}" --family "${ECS_TASK_DEFINITION_NAME}" --cpu ${ECS_CPU_SHARES} --memory ${ECS_MEMORY}  --execution-role-arn "arn:aws:iam::${AWS_ACCOUNT_ID}:role/ecsTaskExecutionRole" --network-mode "awsvpc" --requires-compatibilities "FARGATE" --container-definitions "${NEW_CONTAINER_DEF}" --volumes "${VOLUMES}"

  # Updating service with new task definition
  # aws ecs --profile "${AWS_PROFILE}" update-service --region "${ECS_REGION}" --cluster "${ECS_CLUSTER_NAME}" --service "${ECS_SERVICE_NAME}"  --task-definition "${ECS_TASK_DEFINITION_NAME}"
)
