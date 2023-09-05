variable "details" {
	default = null
	type    = any
}

variable "event_pattern" {
	default = null
	type    = string
}

variable "lambda" {
	type = object({
		arn = string
	})
}

variable "schedule_expression" {
	default = null
	type    = string
}

