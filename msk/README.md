
# Kafka ACL Management and Configuration

This README provides instructions to set up and run a Terraform configuration for managing Kafka ACLs and server properties for AWS MSK (Managed Streaming for Apache Kafka).

## Prerequisites

Before running the Terraform configuration, ensure the following tools and services are installed and configured:

1. **Terraform**: Install Terraform from [here](https://www.terraform.io/downloads).
2. **AWS CLI**: Install the AWS CLI to interact with AWS services. Follow installation instructions [here](https://aws.amazon.com/cli/).
3. **Kafka**: You should have Kafka installed on your local machine or use the Kafka client provided by AWS MSK. Ensure that the `kafka-topics` and `kafka-acls` tools are available in your path.
4. **AWS MSK**: A running MSK cluster is required, or you can provision one using Terraform.
5. **Bash**: This script is written for a Unix-based shell (bash). Ensure you have bash available if you are using a Windows machine (e.g., through Git Bash or Windows Subsystem for Linux).

## Setup Steps

### 1. Clone the Repository

Clone the repository or download the Terraform configuration and shell scripts into your local machine.

```bash
git clone https://your-repository-url.git
cd your-repository-folder
```

### 2. Configure AWS Credentials

Make sure your AWS credentials are set up in one of the following ways:

- **Environment variables**:

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

- **AWS CLI configuration**:

```bash
aws configure
```

### 3. Modify `server.properties`

Edit the `server.properties` file to match your Kafka broker settings. For example, you may want to modify the retention policy, segment size, or other configurations based on your requirements.

```bash
log.retention.ms=86400000
log.segment.bytes=536870912
```

### 4. Modify the `kafka_acl.sh` Script

Update the `kafka_acl.sh` script with the appropriate values for your Kafka broker, username, and password:

```bash
BROKER="b-1.example.kafka.amazonaws.com:9094"
USER="your-username"
PASS="your-password"
```

Make sure the broker address points to your MSK cluster.

### 5. Install Terraform Providers (Optional)

If you are using Terraform to provision MSK resources, ensure that the AWS provider is configured in your Terraform files. Below is an example provider setup:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### 6. Initialize Terraform

Initialize the Terraform configuration:

```bash
terraform init
```

### 7. Apply Terraform Configuration

Run Terraform to apply the configuration. This can provision resources like MSK clusters, IAM roles, and more.

```bash
terraform apply
```

Confirm any prompts and let Terraform provision the necessary infrastructure.

### 8. Run the Kafka ACL Script

Once your Kafka infrastructure is up and running, execute the `kafka_acl.sh` script to create topics and apply ACLs to them.

```bash
chmod +x kafka_acl.sh
./kafka_acl.sh
```

This script will:

1. Create a new Kafka topic called `new-topic`.
2. Add an ACL to allow the specified user full access to the topic.

### 9. Testing

After running the script, test if the ACLs and topics were created correctly:

- List Kafka topics:

```bash
kafka-topics --list --bootstrap-server <BROKER_ADDRESS>
```

- Check the ACLs:

```bash
kafka-acls --list --bootstrap-server <BROKER_ADDRESS>
```

Ensure that the created ACLs are applied to the `new-topic`.

---

### Troubleshooting

- **Error with `kafka-topics` or `kafka-acls`**: Ensure that your Kafka client tools are properly installed and that the broker address is reachable.
- **AWS MSK issues**: If there are any connectivity issues with AWS MSK, verify that your AWS security groups, VPCs, and IAM permissions are correctly configured.
