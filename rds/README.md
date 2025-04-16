
# Terraform AWS RDS Deployment

This project provisions an AWS RDS instance using Terraform. It includes all necessary configurations to deploy the RDS instance securely with the specified parameters.

## Prerequisites

Before running the Terraform scripts, make sure you have the following installed:

- [Terraform](https://www.terraform.io/downloads) (v1.0 or higher)
- [AWS CLI](https://aws.amazon.com/cli/) (configured with access credentials)

## Setup Instructions

### 1. Clone this repository
```bash
git clone <your-repository-url>
cd <your-repository-directory>
```

### 2. Set up your AWS credentials

Make sure your AWS credentials are configured. You can do this by running:

```bash
aws configure
```

Alternatively, you can pass the credentials directly via the `terraform.tfvars` file.

### 3. Update `terraform.tfvars`

Make sure the values in `terraform.tfvars` are correct for your environment:
- `aws_access_key` and `aws_secret_key` should be replaced with your AWS IAM credentials (or use AWS CLI credentials).
- Modify `region`, `db_name`, `engine`, `db_user`, `db_password`, `instance_class`, and other values as per your requirements.

### 4. Initialize Terraform
To download the necessary Terraform providers and initialize the project, run:

```bash
terraform init
```

### 5. Plan the deployment
To see the planned changes before applying them, run:

```bash
terraform plan
```

This will show you the resources that will be created, modified, or destroyed.

### 6. Apply the Terraform configuration
To deploy the resources defined in your `rds.tf` file, run:

```bash
terraform apply
```

You will be prompted to confirm the action by typing `yes`.

### 7. Access the Outputs
After the deployment is complete, Terraform will output the following values:
- `db_user`: The master username for the database.
- `db_password`: The master password for the database.
- `db_endpoint`: The endpoint URL of the deployed RDS instance.

### 8. Test the deployment

To verify that your RDS instance is up and running, use the `db_endpoint` and `db_user` credentials to connect to your database from a client like `psql` (for PostgreSQL) or `mysql` (for MySQL).

Example for PostgreSQL:

```bash
psql -h <db_endpoint> -U <db_user> -d <db_name>
```

### 9. Clean up

When you no longer need the resources, you can destroy them with:

```bash
terraform destroy
```

This will remove all resources defined in your Terraform files.
