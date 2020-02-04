# Prepare env variables
export AWS_PROFILE ENV_FILE_PATH="s3://${AWS_SYSADMIN_BUCKET}/env/${AWS_ENV}/${APPLICATION_NAME}/.env"
export ECR_URI ECS_REGION ECS_CLUSTER_NAME AWS_ACCOUNT_ID AWS_ENV ENV_FILE_PATH APPLICATION_NAME ECS_TASK_DEFINITION_NAME ECS_SERVICE_NAME ECS_VOLUME_NAME
/app/src/create-aws-creds.sh

# Copy AWS config file
cp /app/src/aws-config ~/.aws/config

# Run script to update docker image on ECS
/app/src/update-docker.sh
