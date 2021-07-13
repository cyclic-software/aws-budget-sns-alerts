#!/usr/bin/env bash

set -exou pipefail

cd $(dirname $0)

cfn-lint -t spike-infra-template.yaml

# aws cloudformation validate-template \
#     --template-body ./template.yaml

aws cloudformation deploy \
    --template-file ./spike-infra-template.yaml \
    --parameter-overrides ParamWebhookUrl=$1 \
    --stack-name spike-sns-alert

cfn-lint -t budget-template.yaml

# aws cloudformation validate-template \
#     --template-body ./template.yaml

aws cloudformation deploy \
    --template-file ./budget-template.yaml \
    --stack-name budget-alert
