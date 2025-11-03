# Use AWS EC2 Instance as an Agent for Azure DevOps Pipelines

This is task will create an ec2 instance using terraform we will use that ec2 instance run the azure devops pipelines connecting it as an agent.

## Terraform

Terraform will help to launch an ec2 instance. Let's run the terraform commands:

    ```sh
    terraform init
    terraform plan
    terraform apply -auto-approve
    ```

## Setup as an Agent

To setup the ec2 instance as an agent for azure devops pipelines, follow this [google docs](https://docs.google.com/document/d/1tj_LH9A9nmyvLstAMNLmM8TvpFqitIl-shiYl9KEQ-U/edit?usp=sharing).
