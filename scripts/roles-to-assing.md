---

# Azure Managed Identity Role Assignments for VM

To enable the **Azure Virtual Machine**'s **Managed Identity** to access various resources like **Storage Accounts**, specific role assignments are required. Below are the necessary role assignments for the **Managed Identity** of the VM in your Azure environment.

### Prerequisites:
- Replace the placeholders in the following commands with the specific details of your project:
    - `$(subscriptionId)` → Your Azure Subscription ID.
    - `$(resourceGroupName)` → The name of your Resource Group.
    - `$(storageAccountA)` → The name of your first Storage Account .
    - `$(storageAccountB)` → The name of your second Storage Account .
    - `$(assigneePrincipalId)` → The **Principal ID** (Managed Identity) of the VM. This is typically the **Azure Managed Identity**'s ID that is used to access Azure resources.

### Role Assignment Commands

Use the following **Azure CLI** commands to assign the necessary roles to the **Managed Identity** of your VM. Ensure that the **Managed Identity** has the right permissions to perform the required actions.

```bash
# The **Principal ID** (Managed Identity) of the VM can be accessed by command after you logged in to your acount (az login):
az vm identity show --resource-group $(resourceGroupName) --name $(vmName) --query principalId

Assign "Storage Blob Data Reader" role to the Managed Identity for access to the first storage account
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage Blob Data Reader" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Storage/storageAccounts/$(storageAccountA)

# Assign "Storage File Data Privileged Reader" role to the Managed Identity for access to the first storage account
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage File Data Privileged Reader" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Storage/storageAccounts/$(storageAccountA)

# Assign "Storage Blob Data Contributor" role to the Managed Identity for access to the second storage account
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage Blob Data Contributor" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Storage/storageAccounts/$(storageAccountB)

# Assign "Storage Blob Data Contributor" role to the Managed Identity for access to the first storage account
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage Blob Data Contributor" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Storage/storageAccounts/$(storageAccountA)

# Assign "Storage File Data Privileged Reader" role to the Managed Identity for access to the second storage account
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage File Data Privileged Reader" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Storage/storageAccounts/$(storageAccountB)

# Assign "Storage Blob Data Reader" role to the Managed Identity for access to the second storage account
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage Blob Data Reader" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)/providers/Microsoft.Storage/storageAccounts/$(storageAccountB)

# Assign "Storage File Data Privileged Reader" role to the Managed Identity for access to the entire resource group
az role assignment create --assignee "$(assigneePrincipalId)" --role "Storage File Data Privileged Reader" --scope /subscriptions/$(subscriptionId)/resourceGroups/$(resourceGroupName)

# Assign "Contributor" role to the Managed Identity at the subscription level
az role assignment create --assignee "$(assigneePrincipalId)" --role "Contributor" --scope /subscriptions/$(subscriptionId)
```

### Description of Roles:

1. **Storage Blob Data Reader**: Provides read access to the blob data in a storage account. This is typically used to allow the managed identity to read blobs from the storage account.

2. **Storage File Data Privileged Reader**: Grants read access to file data at the storage account level. This permission is typically assigned when you want the managed identity to have read access to Azure file shares.

3. **Storage Blob Data Contributor**: Grants permission to modify blob data in a storage account. This role is essential when you want the managed identity to upload, delete, or modify blobs in the storage account.

4. **Contributor**: Grants full management access to Azure resources but does not allow management of access rights. This role is assigned at the subscription level to ensure the VM’s Managed Identity can create and manage resources within the subscription.

---

### Summary:

- Replace the placeholders in the script with actual values in your project.
- These role assignments allow the managed identity of your **Azure Virtual Machine** to access storage accounts and perform operations such as reading and writing blobs.
  
---
