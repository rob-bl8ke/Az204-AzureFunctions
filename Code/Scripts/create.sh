#!/bin/bash

resourcePrefix="..."
resourceGroup=$resourcePrefix"resourcegroup"
location="eastus"
vm1=$resourcePrefix"vm1"
netfncstorage=$resourcePrefix"dotnetfncstorage"
netfncapp=$resourcePrefix"dotnetfncapp"
nodefncstorage=$resourcePrefix"nodefncstorage"
nodefncapp=$resourcePrefix"nodefncapp"
scriptFolder=$PSScriptRoot
folderPath="..."
storageAccount=$resourcePrefix"stdstorageacc"
cosmosDbAccount=$resourcePrefix"cosmosdbacc"
keyvault=$resourcePrefix"stdkeyvault"

# Login to Azure
az login

# Create a resource group
az group create --name $resourceGroup --location $location

# Create .NET Function App
az storage account create \
    --name $netfncstorage \
    --location $location \
    --resource-group $resourceGroup \
    --sku Standard_LRS

az functionapp create \
    --name $netfncapp \
    --resource-group $resourceGroup \
    --location $location \
    --storage-account $netfncstorage \
    --runtime dotnet \
    --runtime-version 6 \
    --functions-version 4 \
    --os-type Windows

# Create Node Function App
az storage account create \
    --name $nodefncstorage \
    --location $location \
    --resource-group $resourceGroup \
    --sku Standard_LRS

az functionapp create \
    --name $nodefncapp \
    --resource-group $resourceGroup \
    --location $location \
    --storage-account $nodefncstorage \
    --runtime node \
    --runtime-version 16 \
    --functions-version 4 \
    --os-type Windows

# .NET
dotnetFuncFolder=$folderPath"dotnetfunc"

if [ ! -d $dotnetFuncFolder ]; then
    mkdir -p $dotnetFuncFolder
    cd $dotnetFuncFolder
    func init --worker-runtime dotnet --source-control false
    func new --name csharpfunc --language "C#" --template "HTTP trigger" --authlevel anonymous
    func azure functionapp publish $netfncapp
    cd $folderPath
    rm -rf $dotnetFuncFolder
fi

# Node
nodeFuncFolder=$folderPath"dotnetfunc"

if [ ! -d $nodeFuncFolder ]; then
    mkdir -p $nodeFuncFolder
    cd $nodeFuncFolder
    func init --worker-runtime node --language javascript --source-control false
    func new --name javascriptfunc --language javascript --template "HTTP trigger" --authlevel anonymous --model V3
    npm install
    npm run build
    func azure functionapp publish $nodefncapp
    cd $folderPath
    rm -rf $nodeFuncFolder
fi
