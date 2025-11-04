# React App Deployment with Azure DevOps

Automated CI/CD pipeline to build, test, and deploy React applications to EC2 using Azure DevOps.

## Prerequisites

- **EC2 Instance** with Nginx installed
- **Azure DevOps Agent** (self-hosted) to run the pipeline
- **React Application** repository
- **Azure DevOps** organization and project

## Setup Steps

### 1. Create Azure DevOps Project

- Navigate to your Azure DevOps organization
- Create a new project

### 2. Import Repository

- Go to **Repos** → **Import repository**
- Import your React application repository

### 3. Create Service Connection

- Go to **Project Settings** → **Service connections**
- Create **SSH** connection named `ec2-nginx-server`
- Configure with your EC2 instance details:
  - Host: EC2 public IP
  - Username: `ubuntu`
  - Private key or password

### 4. Setup Agent Pool

- Go to **Project Settings** → **Agent pools**
- Create pool named `aws-ubuntu`
- Install and configure agent on your system

### 5. Create Pipeline

- Go to **Pipelines** → **New pipeline**
- Select **Azure Repos Git**
- Choose your repository
- Select **Existing Azure Pipelines YAML file**
- Point to `azure-pipelines.yml`

### 6. Run Pipeline

- Save and run the pipeline
- Grant permissions when prompted
- Monitor the deployment process

## Pipeline Stages

1. **Build** - Compiles React app (`npm run build`)
2. **Test** - Runs test suite (`npm test`)
3. **Deploy** - Copies files to EC2 `/var/www/html`
4. **Configure** - Sets up Nginx for React SPA

## Variables

- `sshService`: `ec2-nginx-server`
- `webRoot`: `/var/www/html`
- `sshUser`: `ubuntu`
- `artifactName`: `react-build`
