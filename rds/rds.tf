# Input Variables
variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "identifier" {
  description = "Name of the database"
  type        = string
}

variable "engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the DB (e.g., db.t3.micro)"
  type        = string
}

variable "allocated_storage" {
  description = "Amount of storage (in GB)"
  type        = number
}

variable "db_user" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master user password for the database"
  type        = string
  sensitive   = true
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "random_password" "password" {
  length  = 8
  special = true
}

resource "aws_db_instance" "this" {
  identifier         = var.identifier
  engine             = var.engine
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  db_name            = var.db_name
  username           = var.db_user
  password           = random_password.password.result
  skip_final_snapshot = true
}

output "db_user" {
  value = var.db_user
}

output "db_password" {
  value     = random_password.password.result
  sensitive = true
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}
