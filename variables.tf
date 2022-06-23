# variables para terraform.tfvars
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
    description = "AWS region in which to launch the servers."
    default = "us-east-1"
}

variable "public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}
