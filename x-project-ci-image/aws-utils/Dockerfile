# Docker version?
# See https://github.com/docker-library/docker/issues/170
FROM docker:18.09.7-dind

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION

RUN apk add --no-cache python py-pip python-dev build-base libressl-dev musl-dev libffi-dev git curl
RUN pip install awsebcli awscli s3cmd

RUN  aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
RUN  aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
RUN  aws configure set region $AWS_REGION
