#!/bin/bash

set -e

echo "This script will install azure devops agent runner"
echo "${OrganizationURL} ${PoolName} ${AgentName}"
# Switch to ubuntu user and run everything as non-root

su - ubuntu -c "
cd /home/ubuntu
mkdir -p myagent && cd myagent
wget https://download.agent.dev.azure.com/agent/4.261.0/vsts-agent-linux-x64-4.261.0.tar.gz
tar zxvf vsts-agent-linux-x64-4.261.0.tar.gz
./config.sh --unattended --url \"${OrganizationURL}\" --auth PAT --token \"${PAT}\" --pool \"${PoolName}\" --agent \"${AgentName}\" --acceptTeeEula --runAsService
sudo ./svc.sh install
sudo ./svc.sh start
"
