module lambda_dynamodb_consumer {
    source = "git::https://github.com/rafaelhueb92/terraform-quick-modules.git?ref=lambda/dynamodb/consumer"
    function_name = "example_function"
}