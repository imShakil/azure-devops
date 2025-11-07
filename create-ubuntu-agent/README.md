# Automated Azure DevOps Agent on AWS EC2

Automated infrastructure to create and configure an EC2 instance as an Azure DevOps self-hosted agent with all necessary dependencies.

## Features

- **Automated Setup**: Creates EC2 instance and configures agent via cloud-init
- **Pre-installed Tools**: Terraform, Ansible, AWS CLI, Python3
- **Unique Agent Names**: Uses random pet names for unique agent identification
- **Ready to Use**: Agent automatically registers and starts on boot

## Prerequisites

- AWS CLI configured with appropriate permissions
- Azure DevOps organization with agent pool created
- Personal Access Token (PAT) with Agent Pools (read, manage) scope
- SSH key pair for EC2 access

## Setup

### 1. Configure Variables

Create `terraform.tfvars` file:

```hcl
orgURL = "https://dev.azure.com/your-organization"
personal_access_token = "your-pat-token"
agent_pool_name = "aws-ubuntu"
ssh_public_key_path = "~/.ssh/id_rsa.pub"
```

### 2. Deploy Infrastructure

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### 3. Verify Agent

- Check Azure DevOps → Project Settings → Agent pools → aws-ubuntu
- Agent should appear as online with name format: `aws-ubuntu-agent-{random-pet-name}`

## Output

Terraform provides:

- EC2 public/private IP addresses
- SSH connection command
- Generated agent name

## Agent Capabilities

The agent comes pre-configured with:

- **Terraform** - Infrastructure as Code
- **Ansible** - Configuration management
- **AWS CLI** - AWS service interactions
- **Python3** - Scripting and automation
- **Node.js** - For React/JavaScript builds

## Cleanup

```bash
terraform destroy -auto-approve
```

This will remove the EC2 instance and automatically unregister the agent from Azure DevOps.
