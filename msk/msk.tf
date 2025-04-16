# Main provider and AWS configuration
terraform {
  required_providers {
    kafka = {
      source = "Mongey/kafka"
      version = "0.9.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# MSK Cluster Configuration
resource "aws_msk_cluster" "fevpoc" {
  cluster_name     = "fevpoc-msk-cluster"
  kafka_version    = "2.8.0" 
  number_of_broker_nodes = 4

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  broker_node_group_info {
    instance_type   = var.instance_type
    client_subnets  = var.client_subnets
    security_groups = var.security_groups
  }

  tags = {
    Name = "fevpoc-msk-cluster"
  }
}

# MSK Configuration Resource
resource "aws_msk_configuration" "fevpoc" {
  name             = "fevpoc-msk-configuration"
  kafka_versions   = ["2.8.0"]
  server_properties = file("server.properties")
}

# Kafka Topic Creation (Using a script)
resource "null_resource" "create_kafka_topic" {
  provisioner "local-exec" {
    command = "./kafka_acl.sh"
  }

  depends_on = [aws_msk_cluster.fevpoc]
}

# Input Variables
variable "bootstrap_servers" {
  description = "The bootstrap servers of the MSK cluster"
  type        = string
}

variable "ca_cert_path" {
  description = "Path to the CA certificate"
  type        = string
}

variable "client_cert_path" {
  description = "Path to the client certificate"
  type        = string
}

variable "client_key_path" {
  description = "Path to the client key"
  type        = string
}

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

variable "client_subnets" {
  description = "List of subnet IDs for the MSK brokers"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the MSK brokers"
  type        = list(string)
}

variable "instance_type" {
  description = "The instance type for the MSK brokers"
  type        = string
}