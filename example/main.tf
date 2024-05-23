module lambda_sqs_consumer {
    source = "git::https://github.com/rafaelhueb92/terraform-quick-modules.git?ref=lambda/sqs/consumer"
    function_name = "example_function"
}