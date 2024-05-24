# Terraform Quick Modules - Lambda DynamoDB Module

This repository contains a Terraform module for quickly provisioning a Lambda function that accesses a DynamoDB table on AWS.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Terraform Quick Modules provide pre-built modules to streamline the process of setting up common AWS infrastructure configurations. This specific module (`lambda-dynamodb`) focuses on provisioning a Lambda function and a DynamoDB table, along with the necessary IAM policies.

## Prerequisites

Before using this Terraform module, ensure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)

You also need to configure your AWS credentials on your local machine using the `aws configure` command.

## Usage

To use this module in your Terraform configuration, include it as a source module in your `.tf` file:

```hcl
module "lambda_dynamodb" {
  source = "github.com/rafaelhueb92/terraform-quick-modules//lambda/dynamodb"
  
  # Specify input variables here, if any
}
