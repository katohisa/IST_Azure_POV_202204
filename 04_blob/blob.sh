#!/usr/bin/bash
STORAGE_ACCOUNT_NAME=tfstate20220518
CONTAINER_NAME=tfstate
RG=stg
# Create storage account
az storage account create --resource-group $RG --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

