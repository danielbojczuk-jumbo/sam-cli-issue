resource "aws_cloudwatch_event_rule" "every_day" {
  name                = "execute-every-day"
  description         = "Execute every day"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "every_day" {
  rule = aws_cloudwatch_event_rule.every_day.name
  arn  = module.lambda_function.lambda_function_arn
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name                     = "sam-cli-test"
  description                       = "Test of SAM CLI"
  handler                           = "lambda_function.lambda_handler"
  runtime                           = "python3.12"
  timeout                           = 580
  memory_size                       = 512
  cloudwatch_logs_retention_in_days = 1

  source_path = [{
    path             = "../src/"
    pip_requirements = "../src/requirements.txt"
  }]

  publish = true
  allowed_triggers = {
    RunEveryDay = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.every_day.arn
    }
  }

  attach_policy_statements = true


  environment_variables = {
    SOME_VARIABLE    = "abc"
  }

  layers = [
    "arn:aws:lambda:eu-central-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:68",
  ]

  create_sam_metadata = true
}


