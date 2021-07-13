# from: https://unix.stackexchange.com/questions/235223/makefile-include-env-file
# export $(shell sed 's/=.*//' .env)
include .env
export

test:
	env

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