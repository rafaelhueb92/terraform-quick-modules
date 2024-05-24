locals {
    account_id = data.aws_caller_identity.current.account_id
    dynamodb_name = var.dynamodb_name == "" ? var.dynamodb_name : "queue_${var.function_name}"
}