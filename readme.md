Terraform Quick Modules: Lambda and DynamoDB
Overview
Terraform-Quick-Modules repository provides a collection of reusable Terraform modules for provisioning resources in AWS. This particular module, located in the "lambda/dynamodb" branch, allows users to quickly set up AWS Lambda functions and DynamoDB tables in their AWS accounts.

Getting Started
Cloning the Repository
To get started, clone the Terraform-Quick-Modules repository to your local environment:

bash
Copiar código
git clone -b lambda/dynamodb https://github.com/rafaelhueb92/terraform-quick-modules.git
Configuring AWS Credentials
Before proceeding, ensure that you have your AWS credentials configured locally. You can export your access keys as environment variables or configure the ~/.aws/credentials file. Make sure the credentials have sufficient permissions to create the necessary resources.

Using the Module in Your Terraform Project
Once you have cloned the repository and configured your AWS credentials, you can start using the module in your Terraform project. Below is an example of how to use the module to create a Lambda function and a DynamoDB table:

terraform
Copiar código
provider "aws" {
  region = "us-west-2"
}

module "lambda_dynamodb" {
  source              = "./lambda-dynamodb"
  function_name       = "my-lambda-function"
  lambda_handler      = "lambda_function.lambda_handler"
  runtime             = "python3.8"
  environment_variables = {
    TABLE_NAME = "my-dynamodb-table"
  }
}

output "lambda_function_arn" {
  value = module.lambda_dynamodb.lambda_function_arn
}

output "dynamodb_table_name" {
  value = module.lambda_dynamodb.dynamodb_table_name
}
In this example, we are using the lambda-dynamodb module from the Terraform-Quick-Modules repository. We pass several necessary parameters, such as the Lambda function name, handler, runtime, and environment variables required for the Lambda function to communicate with the DynamoDB table.

Applying the Configurations
After defining your main.tf file, you can execute the following commands to apply the configurations:

bash
Copiar código
terraform init
terraform apply
This will initialize Terraform and apply the configurations defined in your main.tf file. Make sure to review the proposed changes before confirming the application.

Conclusion
The Terraform-Quick-Modules repository offers a convenient way to provision common resources in AWS quickly and easily. By using pre-configured modules like the one available in the "lambda/dynamodb" branch, you can save time and effort in setting up cloud infrastructure.

Feel free to explore other modules available in the repository and adapt them to the specific needs of your projects. With the flexibility and power of Terraform, the possibilities are endless.