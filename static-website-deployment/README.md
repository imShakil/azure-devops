# Static Website Deployment to Nginx Server Using Azure DevOps Pipeline

## Terraform

Terraform section allows to generate a ec2 instance while ensure a private key file generated locally and updated ansible inventory file. This private key file also has granted appropriate permission.

Make sure you are in the terraform directory and run the following commands

    ```sh
    terraform init
    terraform plan
    terraform apply -auto-approve
    ```

## Ansible

Ansible part will help to install and setup nginx server in the following ec2 instance that's created through terraform command.

Make sure you are in the ansible directory and run the ansible playbook command:

    ```sh
    ansible-palybook -i inventory.ini playbook.yml
    ```

## Setting Azure DevOps Pipeline

To deploy the static website with the azure devops pipeline kindly checkout this [google docs](https://docs.google.com/document/d/1tj_LH9A9nmyvLstAMNLmM8TvpFqitIl-shiYl9KEQ-U/edit?usp=sharing).
