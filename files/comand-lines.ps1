$templateFile = "C:\Users\Victoria\Desktop\Self_Learning\microsoft_homewor\azuredeploy.json"
New-AzResourceGroupDeployment -Name blanktemplate -ResourceGroupName Vivanov-RG -TemplateFile $templateFile
New-AzResourceGroupDeployment -Name storage-account-1 -ResourceGroupName Vivanov-RG -TemplateFile $templateFile -storagePrefix "store-1" -storageSKU Standard_LRS

$templateFile = "C:\Users\Victoria\Desktop\Self_Learning\microsoft_homework\files\arm-template-storage-account.json"
$parameterFile="C:\Users\Victoria\Desktop\Self_Learning\microsoft_homework\files\parameters_store.json}"
New-AzResourceGroup -Name myResourceGroupDev -Location "East US"
New-AzResourceGroupDeployment -Name storage-account-1 -ResourceGroupName Vivanov-RG -TemplateFile $templateFile -TemplateParameterFile $parameterFile



echo "Enter the Resource Group name:" &&
read resourceGroupName &&
echo "Enter the location (i.e. centralus):" &&
read location &&
echo "Enter the project name (used for generating resource names):" &&
read projectName &&
echo "Enter the administrator username:" &&
read username &&
echo "Enter the SSH public key:" &&
read key &&
az group create --name $resourceGroupName --location "$location" &&
az deployment group create --resource-group $resourceGroupName --template-uri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/quickstarts/microsoft.compute/vm-sshkey/azuredeploy.json --parameters projectName=$projectName adminUsername=$username adminPublicKey="$key" &&
$templateVMfile = "C:\Users\Victoria\Desktop\Self_Learning\microsoft_homework\files\arm-template2-vm-linux.json"
$parameterVMfile = "C:\Users\Victoria\Desktop\Self_Learning\microsoft_homework\files\paramsVM.json"
az deployment group create --resource-group Vivanov-RG --template-uri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/quickstarts/microsoft.compute/vm-sshkey/azuredeploy.json --parameters projectName=$projectName adminUsername=$username adminPublicKey="$key" &&
az deployment group create \
  --resource-group Vivanov-RG \
  --template-file arm-template2-vm-linux.json \
  --parameters parametersVM.json

az vm show --resource-group Vivanov-RG --name "vivanov1-vm" --show-details --query publicIps --output tsv
az vm show --resource-group Vivanov-RG --name "vivanov1-vm" --show-details --query publicIps --output tsv
20.217.218.102
 ssh -i id_rsa.pem azureuser@20.217.218.102
