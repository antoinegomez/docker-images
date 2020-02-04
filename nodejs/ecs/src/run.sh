# Prepare env variables
export AWS_PROFILE ENV_FILE_PATH="s3://${AWS_SYSADMIN_BUCKET}/env/${AWS_ENV}/${APPLICATION_NAME}/.env"
export AWS_ACCOUNT_ID AWS_ENV ENV_FILE_PATH APPLICATION_NAME CLUSTER ECS_TASK_DEFINITION_NAME ECS_SERVICE_NAME ECS_VOLUME_NAME
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID_PROD} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY_PROD} ./scripts/create-aws-creds.sh

# Copy AWS config file
cp docker/aws-config ~/.aws/config

# Run script to update docker image on ECS
./src/update-docker.sh
