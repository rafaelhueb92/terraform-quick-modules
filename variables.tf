variable "function_name" {
    type = string
}

variable "handler" {
    type = string
    default = "index.handler"
}

variable "runtime" {
    type = string
    default = "nodejs14.x"
}

variable "sqs_name" {
    type = string
    default = ""
}

variable "delay_seconds" {
    type = number
    default = 90
}

variable "max_message_size" {
    type = number
    default = 2048
}

variable "message_retention_seconds" {
    type = number
    default = 86400
}

variable "visibility_timeout_seconds" {
    type = number
    default = 30
}