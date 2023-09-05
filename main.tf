resource "aws_cloudwatch_event_rule" "this" {
	event_pattern       = var.details != null ? jsonencode({ detail = var.details }) : var.event_pattern
	name_prefix         = "tf-eventbridge-invoke-lambda-rule-"
	schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "this" {
	arn  = var.lambda.arn
	rule = resource.aws_cloudwatch_event_rule.this.name
}

resource "aws_lambda_permission" "this" {
	action        = "lambda:InvokeFunction"
	function_name = var.lambda.arn
	principal     = "events.amazonaws.com"
	source_arn    = resource.aws_cloudwatch_event_rule.this.arn
}
