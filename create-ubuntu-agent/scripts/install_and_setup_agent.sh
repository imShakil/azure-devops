#!/bin/bash

set -e

echo "Setting up Azure DevOps self-hosted agent with dependencies..."

# Update system
apt update -y

# Install basic tools
apt-get install unzip wget curl -y

# Install Python
if ! command -v python3 &> /dev/null; then
    echo "Installing Python3..."
    apt install python3 python3-pip -y
fi

# Install Ansible
if ! command -v ansible &> /dev/null; then
    echo "Installing Ansible..."
    apt install ansible -y
fi

# Install Terraform
if ! command -v terraform &> /dev/null; then
    echo "Installing Terraform..."
    wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
    apt update && apt install terraform -y
fi

# Install AWS CLI
if ! command -v aws &> /dev/null; then
    echo "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install
    rm -rf aws awscliv2.zip
fi

echo "Dependencies installed. Now installing Azure DevOps agent..."
echo "${OrganizationURL} ${PoolName} ${AgentName}"

# Install Azure DevOps agent
su - ubuntu -c "
cd /home/ubuntu
mkdir -p myagent && cd myagent
wget https://download.agent.dev.azure.com/agent/4.261.0/vsts-agent-linux-x64-4.261.0.tar.gz
tar zxvf vsts-agent-linux-x64-4.261.0.tar.gz
./config.sh --unattended --url \"${OrganizationURL}\" --auth PAT --token \"${PAT}\" --pool \"${PoolName}\" --agent \"${AgentName}\" --acceptTeeEula --runAsService
rm vsts-agent-linux-x64-4.261.0.tar.gz
sudo ./svc.sh install
sudo ./svc.sh start
"

echo "Azure DevOps agent setup complete!"