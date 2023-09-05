# terraform-aws-eventbridge-invoke-lambda

Terraform AWS Eventbridge rules to invoke AWS Lambda functions using Cloudevents

## Inputs

One of `details`, `event_pattern`, or `schedule_expression` are required. If multiple are input, only one will actually be used.

| Name                | Required | Types  | Default | Description                                                                                    |
|---------------------|----------|--------|---------|------------------------------------------------------------------------------------------------|
| details             |          | object |         | The event pattern hooking only into the details (e.g. payload, cloudevent) of the AWS payload. |
| event_pattern       |          | string |         | The event pattern hooking into the whole AWS payload.                                          |
| lambda.arn          | yes      | string |         | ARN of the AWS Lambda to be invoked.                                                           |
| schedule_expression |          | string |         | The schedule expression (e.g. `rate(1234 hours)`, `cron(15 10 ? * 6L 2019-2022)`)              |

## Usage

See [examples folder](https://github.com/1Mill/terraform-aws-eventbridge-invoke-lambda/tree/main/examples) for full working examples.

```hcl
module "rule_details" {
  source = "1Mill/eventbridge-invoke-lambda/aws"

  lambda = { arn = module.lambda.arn }

  details = {
    types       = ["cmd.placeholder.v0"]
    wschannelid = [{ exists = true }]
  }
}

module "rule_schedule_expression" {
  source = "../.."

  lambda = { arn = module.lambda.arn }
  schedule_expression = "rate(1234 minutes)"
}

module "rule_event_pattern" {
  source = "../.."

  event_pattern = jsonencode({ source = ["build.cloudevents.gdn"] })
  lambda = { arn = module.lambda.arn }
}
```

## Examples

1. Run `cd examples/simple`
1. Run `terraform init`
1. Run `terraform apply -auto-approve`
1. View resources created in AWS
1. Run `terraform destroy -auto-approve`
