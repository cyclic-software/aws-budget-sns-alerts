# Budget SNS Alerts

This repo deploys a budget and sns topic that is connected to spike.sh via an https webhook.


## How to deploy

### Spike SNS Alert Topic

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=spike-sns-alert&templateURL=https://s3.amazonaws.com/requestor-pays-296033832429-us-east-2/budget-sns-alerts/main/spike-infra-template.yaml)

### Budget with Notification and Limit

[![Launch Stack](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=budget-alert&templateURL=https://s3.amazonaws.com/requestor-pays-296033832429-us-east-2/budget-sns-alerts/main/budget-template.yaml)

## Working on these stacks

If you want to work on these stacks. Here is the workflow.

### Init/Deploy/Upload

- `make init`: sets up bucket to host Launch Stacks templates **NOTE**: you must turn on requestor pays inside the console.

- `make deploy`: deploy cloudformation stacks for the budget and SNS topic to send alerts. **NOTE** use .env to define Webhook URL

- `make upload`: uploads the budget and sns alert templates
