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
2. [Repository Structure](#repository-structure)
3. [ARM Templates for Storage Accounts and Server](#arm-templates-for-storage-accounts-and-server)
4. [Continuous Deployment Pipeline Setup](#continuous-deployment-pipeline-setup)
5. [Blob Management Script](#blob-management-script)
6. [Metrics and Monitoring](#metrics-and-monitoring)
7. [Getting Started](#getting-started)

---

## Azure Trial Subscription
To begin the project, a trial Azure subscription was created using the [Azure Free Trial Offer](https://azure.microsoft.com/en-in/pricing/offers/ms-azr-0044p). This provides access to Azure resources with a limited budget for testing and development.

---
# Repository Structure

This repository is organized as follows:

```plaintext
.
├── README.md                                 # This file
├── Vivanov1 Dashboard.json                  # Dashboard JSON file
├── azure-CD-create-2-storages-and-LinuxVM-IP.yml  # Pipeline for creating storage accounts and Linux VM
├── azure-CD-create-storage.yml              # Pipeline for creating storage accounts
├── azure-CD-run-blob-script.yml             # Pipeline for running blob creation script
├── parameters/                              # Directory for parameter files
│   ├── parametersVM.json                    # Parameters for the VM template
│   ├── parameters_storage.json              # Parameters for the first storage account template
│   ├── parameters_store_a.json              # Parameters for the second storage account template
│   └── parameters_store_b.json              # Parameters for the second storage account template (another version)
├── scripts/                                 # Directory for scripts
│   └── blob-creation-with-parameters.sh     # Script to create, upload, and copy 100 blobs
├── templates/                               # Directory for ARM templates
│   ├── arm-template-storage-account.json    # ARM template for creating a storage account
│   └── arm-template2-vm-linux.json          # ARM template for creating a Linux VM
└── .git/                                    # Git version control directory (if using git)
```


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

## Continuous Deployment Setup

### Azure DevOps Pipelines
The Continuous Deployment was set up using **Azure DevOps**. It presents as set of Azure Devops pipelines and automates the entire process, including:
- Create Storage Accounts and the Server using the ARM templates in Azure cloud.
- Installation Azure CLI on new created Virtual Machine and trigerring bash script on it for create desired numbers of blobs, uploading them into Storage Account A 
  and then copying those blobs frm Storage Account A to Storage Account B.
- Additional pipeline for create Storage Account for Monitoring Dashbord purpose.
- The Azure DevOps pipeline was configured with a self-hosted Azure DevOps agent, ensuring that permission issues are bypassed.

### Pipeline main Steps:
1. **Deploy ARM Template for Storage Accounts:**
   The pipeline deploys the ARM template to create two storage accounts.
   
2. **Deploy ARM Template for Server:**
   The pipeline provisions  Linux virtual machine (VM) to host and run the blob management script.
       ! Create Role Assignment on Managed Identity is requered after VM is created and running according to the list can be found in scripts directory.

4. **Install AzureCLI on new created VM:**
   The pipeline automatically executes a script that creates, uploads, and copies 100 blobs from Storage Account A to Storage Account B.
   
5. **Run Blob Management Script:**
   The pipeline automatically executes a script that creates, uploads, and copies 100 blobs from Storage Account A to Storage Account B.

  
---

## Blob Management Script

A Bash script was created to perform the following actions:
1. **Create 100 Blobs:** Upload 100 blobs to **Storage Account A**.
2. **Copy Blobs:** Copy the blobs from **Storage Account A** to **Storage Account B**.
3. The script is executed via the CD pipeline on the server created earlier to automate the entire process.

---

## Metrics and Monitoring

The system includes one server and two storage accounts. To ensure the health and performance of this small system, the following metrics are monitored:

- **VM Metrics :** 
   - **CPU Metrics**
   - **Memory Usage** 
   - **Network metrics**
   - **Avalability Metrics** 
- **Storage Account Metrics:**
   - **Used Capacity** , **Blob Container Count** , **Blob Count**
  
![Project Metrics](images/metrics.png)

A **custom dashboard** was created using Azure Monitor to display these key metrics in real-time.

![Project Dashboard](images/dashboard.png)

---

## Getting Started

### Prerequisites:
- Azure Subscription (trial or paid)
- Azure DevOps account
- Personal computer set as an Azure DevOps agent (if needed)
- Create Role Assignment on Managed Identity , requered after VM is created and running according to the list can be found in scripts directory. 

### Steps to Run the Project:
1. **Prepare Azure DevOps Repository:**
   - Clone this repository to Azure Devops account. 
   
2. **Configure Azure DevOps Pipeline:**
   - Create A Variable Group under  Pipeline includes th following variables:
    ```plaintext
    azureSubscription
    location
    projectName
    ```
   - Create an Azure DevOps pipelines , using the existing pipeline files from repository; make sure to configure pipeline private variables per pipeline, they are    also mentioned in the pipelines files.

3. **Run Pipelines in following order:**
   - azure-CD-create-storages-and-VM-IP (Create Role Assignment on Managed Identity , requered after VM is created and running!)
   - azure-CD-run-blob-script
   - azure-CD-create-storageAccount -  Storage Account for Monitoring
     
5. **Verify Blob Copying:**
   - Ensure that blobs are created and copied between storage accounts by checking the storage accounts Resources on Azure Home page.

6. **Monitor Metrics:**
   - Go to **Azure Monitor** in the Azure Portal.
   - Create own custom dashboard or upload json file from home dir of this repository.
   - View the custom dashboard to monitor the server and storage account metrics in real time.

---

## Conclusion

This project demonstrates how to use Azure Resource Manager templates to automate the creation of resources and manage them in a continuous deployment pipeline. By combining ARM templates with Azure DevOps, we have automated the entire infrastructure and blob management workflow, making the system more efficient and scalable. Additionally, setting up metrics and monitoring helps ensure that the system remains healthy and performs optimally.

---


