#!/bin/bash

# Variables and Parameters
sourceStorageAccount=$1
destinationStorageAccount=$2
containerName=$3
blobPrefix=$4
numberOfBlobs=$5
resourceGroup=$6
location=$7
expiryDate=$(date -u -d "+24 hours" +"%Y-%m-%dT%H:%M:%SZ")

# Check if all required parameters are provided
if [ -z "$sourceStorageAccount" ] || [ -z "$destinationStorageAccount" ] || [ -z "$containerName" ] || [ -z "$blobPrefix" ] || [ -z "$numberOfBlobs" ] || [ -z "$resourceGroup" ] || [ -z "$location" ]; then
  echo "Error: Missing required parameter."
  echo "Usage: $0 <sourceStorageAccount> <destinationStorageAccount> <containerName> <blobPrefix> <numberOfBlobs> <resourceGroup> <location>"
  exit 1
fi

echo "Source Storage Account: $sourceStorageAccount"
echo "Destination Storage Account: $destinationStorageAccount"
echo "Container Name: $containerName"
echo "Blob Prefix: $blobPrefix"
echo "Number of Blobs: $numberOfBlobs"
echo "Resource Group: $resourceGroup"
echo "Location: $location"

# Login to Azure (use service principal or managed identity if required)
az login --identity

# Step 1: Generate SAS for Storage Account A (with read permission on blobs)
echo "Generating SAS for Storage Account A..."
sourceSas=$(az storage account generate-sas \
  --account-name $sourceStorageAccount \
  --permissions r \
  --expiry $expiryDate \
  --services b \
  --resource-types o \
  --https-only \
  --output tsv)

# Check if sourceSas is empty
if [ -z "$sourceSas" ]; then
    echo "Error: SAS token for Storage Account A could not be generated."
    exit 1
fi

echo "SAS for Storage Account A generated."

# Step 2: Generate SAS for Storage Account B (with write and create permissions on blobs)
echo "Generating SAS for Storage Account B..."
destinationSas=$(az storage account generate-sas \
  --account-name $destinationStorageAccount \
  --permissions wc \
  --expiry $expiryDate \
  --services b \
  --resource-types co \
  --https-only \
  --output tsv)

# Check if destinationSas is empty
if [ -z "$destinationSas" ]; then
    echo "Error: SAS token for Storage Account B could not be generated."
    exit 1
fi

echo "SAS for Storage Account B generated."

# Step 3: Create Container in Storage Account A
echo "Creating container in Storage Account A..."
az storage container create --name $containerName --account-name $sourceStorageAccount --auth-mode login

# Step 2: Upload 100 blobs to Storage Account A
for i in $(seq 1 $numberOfBlobs)
do
    blobName="${blobPrefix}${i}.txt"
    echo "Uploading $blobName to Storage Account A..."
    echo "This is blob number $i" > /tmp/$blobName
    az storage blob upload --container-name $containerName --file /tmp/$blobName --name $blobName --account-name $sourceStorageAccount --auth-mode login
    rm /tmp/$blobName  # Clean up local file after upload
done

# Step 4: Create container in Storage Account B using SAS
echo "Creating container in Storage Account B..."
az storage container create --name $containerName --account-name $destinationStorageAccount --sas-token $destinationSas

# Step 5: Copy blobs from Storage Account A to B using SAS
for i in $(seq 1 $numberOfBlobs)
do
    blobName="${blobPrefix}${i}.txt"
    echo "Copying $blobName from Storage Account A to B..."
    az storage blob copy start \
        --source-uri "https://$sourceStorageAccount.blob.core.windows.net/$containerName/$blobName?$sourceSas" \
        --destination-container $containerName \
        --destination-blob $blobName \
        --account-name $destinationStorageAccount \
        --sas-token $destinationSas
done

echo "Blob copy operation complete!"