# Azure DevOps Project with CI/CD Pipeline

This project sets up an Azure-based infrastructure using Terraform and deploys a sample application with continuous integration and continuous deployment (CI/CD) through GitHub Actions. The focus is on containerization, security, and monitoring, with integration capabilities for COTS applications and vendor systems like IBM. The project targets multiple environments: Dev, Staging, and Prod.

## Overview of GitHub Actions Workflows

GitHub Actions is used to automate the build, test, and deployment processes whenever new code is pushed to the repository. Here's how the workflows function:

### 1. Terraform Workflow (`terraform.yml`)
- **Trigger**: This workflow is triggered on every push to the `main` branch or on pull requests to `main`.
- **Purpose**: It manages the Azure infrastructure using Terraform.
- **Steps**:
  - **Checkout Code**: Retrieves the latest code from the repository.
  - **Setup Terraform**: Installs and configures Terraform.
  - **Terraform Init**: Initializes Terraform with the Azure backend for state management, using credentials from GitHub Secrets for authentication.
  - **Terraform Format**: Checks the formatting of Terraform files to ensure consistency.
  - **Terraform Plan**: Creates an execution plan for infrastructure changes.
  - **Terraform Apply**: Applies the changes to create or update Azure resources (only on push to `main`).
- **Outcome**: Ensures that the Azure infrastructure (like AKS, ACR, etc.) is up-to-date with the code in the repository.

### 2. Application Workflow (`app.yml`)
- **Trigger**: This workflow runs on push to the `main` branch or on pull requests to `main`, after the Terraform workflow completes successfully.
- **Purpose**: Builds, tests, and deploys the application to Azure Kubernetes Service (AKS).
- **Steps**:
  - **Checkout Code**: Retrieves the latest code from the repository.
  - **Login to Azure Container Registry (ACR)**: Uses credentials from GitHub Secrets to authenticate with ACR.
  - **Build and Push Docker Image**: Builds a Docker image of the application, tests it, and pushes it to ACR.
  - **Deploy to AKS**: (Future step) Deploys the image to AKS cluster for testing and production environments.
- **Outcome**: Automates the process of building a new version of the application, testing it, and deploying it to the AKS cluster, ensuring that the latest code is always running in the environment.

## How It Works Together
When you push new code to the `main` branch:
1. The Terraform workflow runs first to ensure the Azure infrastructure is correctly configured.
2. If successful, the Application workflow triggers to build and deploy the application.
3. This setup allows for continuous integration (building and testing the code) and continuous deployment (deploying to AKS), ensuring that your environments (Dev, Staging, Prod) are always up-to-date with the latest code and infrastructure changes.

## Security and Monitoring
- Azure services like Defender for Cloud, Sentinel, and Monitor are integrated to provide security and performance insights across environments.
- Sensitive credentials are stored in GitHub Secrets to prevent exposure in version control.

## Getting Started
- Ensure you have the necessary Azure credentials set up in GitHub Secrets as described in the workflow files.
- Clone this repository, make changes, and push to see the CI/CD pipeline in action.

For more details on specific configurations or to customize the environments, refer to the Terraform files in the `terraform` directory and the workflow files in `.github/workflows`.
