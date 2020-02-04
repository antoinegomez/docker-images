# ECS update docker image

This docker image is intended to be used to update ECS fargate tasks for GreenJinn.

It contains some scripts that will in the end create a new task definition and then update the service with that task definition.

The script will read some env variables that are stored on a S3 bucket. For now it is only to setup the task CPU and RAM.


# TODO

* Use ecs env file on S3 bucket to store more infos. It will allow to setup the CI with only a few variables: env file path and API key to read the file.
* Generate AWS config file based on env var to allow to change default region
* Use env var for docker registry URI
