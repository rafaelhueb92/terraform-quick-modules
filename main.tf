resource "null_resource" "zip_lambda" {
  provisioner "local-exec" {
    command = "sh scripts/zip_lambda.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_dynamodb_table" "this" {
  name         = local.dynamodb_name
  billing_mode = "PAY_PER_REQUEST"
  
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "example-table"
  }
}

data "archive_file" "lambda_zip" {
  depends_on  = [null_resource.zip_lambda]
  type        = "zip"
  source_file = "lambda_function.zip"
  output_path = "lambda_function.zip"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../../${var.path_source_dir_lambda_code}"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handler
  runtime          = var.runtime
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.example_table.name
    }
  }

  depends_on = [
    resource.aws_dynamodb_table.this,
    aws_iam_role.lambda_exec
  ]

}


data "template_file" "lambda_dynamodb_policy" {
  template = file("${path.module}/policies/lambda_dynamodb_policy.json.tpl")

  vars = {
    dynamodb_table_arn = aws_dynamodb_table.example_table.arn
  }
}

data "template_file" "lambda_policy" {
  template = file("${path.module}/templates/lambda_policy.tpl")

  vars = {
    dynamodb_table_arn = aws_dynamodb_table.this.arn
  }
}

resource "aws_iam_policy" "lambda_dynamodb" {
  name   = "lambda-${var.function_name}-dynamodb-${local.dynamodb_name}-policy"
  policy = data.template_file.lambda_policy.rendered
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_dynamodb.arn
}

