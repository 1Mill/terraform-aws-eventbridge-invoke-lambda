exports.handler = async (event, ctx) => {
	return {
		ctx,
		event,
		message: 'Hello world from terraform-aws-eventbridge-invoke-lambda!',
	}
}
