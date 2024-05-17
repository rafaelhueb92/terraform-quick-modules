data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_function"
  output_path = "${path.module}/example_lambda.zip"
}

resource "aws_lambda_function" "example_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.this.id
    }
  }

  event_source_token = aws_sqs_queue.this.arn

  depends_on = [
    resource.aws_sqs_queue.this
  ]

}

resource "aws_iam_role" "lambda_exec" {
  name               = "lambda-exec-role"
  assume_role_policy = file("iam_policy.json")
}

data "template_file" "lambda_policy" {
  template = file("${path.module}/templates/lambda_policy.tpl")

  vars = {
    queue_arn = aws_sqs_queue.this.arn
  }
}

resource "aws_iam_policy" "lambda_sqs" {
  name   = "lambda-${var.function_name}-sqs-${}-policy"
  policy = data.template_file.lambda_policy.rendered
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_sqs.arn
}

resource "aws_sqs_queue" "this" {
  name                      = "this"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
