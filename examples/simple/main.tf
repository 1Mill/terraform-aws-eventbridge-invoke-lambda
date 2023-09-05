module "lambda" {
	source  = "1Mill/serverless-docker-function/aws"
	version = "~> 3.1"

	docker = { build = abspath(path.module) }
	function = {
		name    = "my-simple-node-lambda"
		version = "some-version-to-avoid-docker-image-rebuilds"
	}
}

# * Create a rule that looks at the details (i.e. payload) of the event
# * to determine if the lambda should be invoked.
module "rule_details" {
	source = "../.."

	lambda = { arn = module.lambda.arn }

	details = {
		types       = ["cmd.placeholder.v0"]
		wschannelid = [{ exists = true }]
	}
}

# * Schedule the lambda to be invoked every 1234 minutes.
module "rule_schedule_expression" {
	source = "../.."

	lambda = { arn = module.lambda.arn }
	schedule_expression = "rate(1234 minutes)"
}

# * Create a rule that can look at the AWS event itself to determine
# * if the lambda should be invoked.
module "rule_event_pattern" {
	source = "../.."

	event_pattern = jsonencode({ source = ["build.cloudevents.gdn"] })
	lambda = { arn = module.lambda.arn }
}
