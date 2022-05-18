#!/usr/bin/bashESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate20220518
CONTAINER_NAME=tfstate
RG = stg
# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

