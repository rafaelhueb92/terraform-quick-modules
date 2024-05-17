locals {
    account_id = data.aws_caller_identity.current.account_id
    sqs_name = var.sqs_name == "" ? var.sqs_name : "queue_${var.function_name}"
}