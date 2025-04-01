# Azure Automation Exercire with ARM Templates and Continuous Deployment Pipeline

## Project Overview
This project focuses on automating the creation and management of Azure resources using Azure Resource Manager (ARM) templates and integrating the deployment process with Azure DevOps pipelines for continuous deployment. The following steps outline the tasks completed for this project:

1. Created a trial Azure subscription to work within Azure.
2. Developed ARM templates to automate the creation of:
   - Two Azure Storage Accounts
   - Linux Server
3. Set up a Continuous Deployment (CD) pipelines in Azure DevOps for automated deployment.
4. Implemented a script to manage storage blobs, including:
   - Creating and uploading blobs to one of the storages
   - Copying blobs from one storage account to another
5. Configured metrics and monitoring for the system, which includes one server and two storage accounts, with a dashboard to display key metrics.

---

## Table of Contents
1. [Azure Trial Subscription](#azure-trial-subscription)
2. [ARM Templates for Storage Accounts and Server](#arm-templates-for-storage-accounts-and-server)
3. [Continuous Deployment Pipeline Setup](#continuous-deployment-pipeline-setup)
4. [Blob Management Script](#blob-management-script)
5. [Metrics and Monitoring](#metrics-and-monitoring)
6. [Getting Started](#getting-started)

---

## Azure Trial Subscription
To begin the project, a trial Azure subscription was created using the [Azure Free Trial Offer](https://azure.microsoft.com/en-in/pricing/offers/ms-azr-0044p). This provides access to Azure resources with a limited budget for testing and development.

---

## ARM Templates for Storage Accounts and Server

ARM Templates files are located under template 
### Storage Accounts ARM Template
An ARM template was created to deploy two Azure Storage Accounts. The template defines the necessary parameters for storage accounts, including:
- **Name**
- **Location**
- **Account type (e.g., Standard_LRS)**

### Server ARM Template
A separate ARM template was created to provision  **Linux** server. This template defines:
- **Virtual Machine Size**
- **Operating System (Windows/Linux)**
- **Networking Configuration**
- **Storage Configuration**

---

## Continuous Deployment Pipeline Setup

### Azure DevOps Pipeline
The Continuous Deployment pipeline was set up using **Azure DevOps**. This pipeline automates the entire process, including:
- Deploying Storage Accounts and the Server using the ARM templates.
- The Azure DevOps pipeline was configured with a self-hosted Azure DevOps agent, ensuring that permission issues are bypassed.

### Pipeline Steps:
1. **Deploy ARM Template for Storage Accounts:**
   The pipeline deploys the ARM template to create two storage accounts.
   
2. **Deploy ARM Template for Server:**
   The pipeline provisions a virtual machine (VM) to host and run the blob management script.

3. **Run Blob Management Script:**
   The pipeline automatically executes a script that creates, uploads, and copies 100 blobs from Storage Account A to Storage Account B.

---

## Blob Management Script

A PowerShell or Bash script was created to perform the following actions:
1. **Create 100 Blobs:** Upload 100 blobs to **Storage Account A**.
2. **Copy Blobs:** Copy the blobs from **Storage Account A** to **Storage Account B**.
3. The script is executed via the CD pipeline on the server created earlier to automate the entire process.

---

## Metrics and Monitoring

The system includes one server and two storage accounts. To ensure the health and performance of this small system, the following metrics are monitored:

- **CPU Usage** on the VM
- **Disk Usage (Free Space)** on the VM
- **Network In/Out traffic** for both the VM and the Storage Accounts
- **Storage Account Metrics:**
   - **Used Capacity** and **Free Space**
   - **Transaction Rate** and **Ingress/Egress**

A **custom dashboard** was created using Azure Monitor to display these key metrics in real-time.

---

## Getting Started

### Prerequisites:
- Azure Subscription (trial or paid)
- Azure DevOps account
- Personal computer set as an Azure DevOps agent (if needed)

### Steps to Run the Project:
1. **Deploy ARM Templates:**
   - Clone the repository or get the ARM templates ready.
   - Use Azure DevOps or the Azure CLI to deploy the ARM templates for the Storage Accounts and Server.
   
2. **Configure Azure DevOps Pipeline:**
   - Create an Azure DevOps pipeline.
   - Use the `azure-cli` task to invoke ARM templates.
   - Add a script task to execute the blob management script.

3. **Verify Blob Copying:**
   - Ensure that blobs are created and copied between storage accounts by checking the storage account metrics and the output logs of the pipeline.

4. **Monitor Metrics:**
   - Go to **Azure Monitor** in the Azure Portal.
   - View the custom dashboard to monitor the server and storage account metrics in real time.

---

## Conclusion

This project demonstrates how to use Azure Resource Manager templates to automate the creation of resources and manage them in a continuous deployment pipeline. By combining ARM templates with Azure DevOps, we have automated the entire infrastructure and blob management workflow, making the system more efficient and scalable. Additionally, setting up metrics and monitoring helps ensure that the system remains healthy and performs optimally.

---


