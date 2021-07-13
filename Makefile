# from: https://unix.stackexchange.com/questions/235223/makefile-include-env-file
# export $(shell sed 's/=.*//' .env)
include .env
export

BRANCH=$(shell git rev-parse --abbrev-ref HEAD | sed 's/^head/main/')
BUCKET_NAME=requestor-pays-296033832429-us-east-2

test:
	env

init:
	cfn-lint -t requestor-pays-bucket-template.yaml

	aws cloudformation deploy \
		--template-file ./requestor-pays-bucket-template.yaml \
		--stack-name requestor-pays-bucket

deploy:
	cfn-lint -t spike-infra-template.yaml
# aws cloudformation validate-template \
#     --template-body ./template.yaml

	aws cloudformation deploy \
		--template-file ./spike-infra-template.yaml \
		--parameter-overrides ParamWebhookUrl=${SPIKE_WEBHOOK_URL} \
		--stack-name spike-sns-alert

	cfn-lint -t budget-template.yaml

# aws cloudformation validate-template \
#     --template-body ./template.yaml

	aws cloudformation deploy \
		--template-file ./budget-template.yaml \
		--stack-name budget-alert

upload:
	aws s3 cp ./spike-infra-template.yaml s3://${BUCKET_NAME}/budget-sns-alerts/${BRANCH}/spike-infra-template.yaml
	aws s3 cp ./budget-template.yaml s3://${BUCKET_NAME}/budget-sns-alerts/${BRANCH}/budget-template.yaml
