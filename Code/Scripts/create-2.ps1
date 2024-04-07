$resourceGroup="...resourcegroup3"
$location="eastus"
$storageAccount="...dotnetfuncstorage"
$funcApp="...dotnetfuncapp"
$url = "https://$funcApp.azurewebsites.net/api/csharpfunc?name=..."

# Check if you're logged in to Azure
if (-not (az account show --query user.name)) {
    # If you're not logged in, perform az login
    az login
}
else {
    # If you're logged in, display a message
    Write-Host "You're already logged in to Azure as $(az account show --query user.name -o tsv)."
}

# Create resource group and required standard SKU storage account
az group create --name $resourceGroup --location $location

az storage account create --name $storageAccount --location $location --resource-group $resourceGroup --sku Standard_LRS --allow-blob-public-access false

# Create the function app
az functionapp create --name $funcApp --resource-group $resourceGroup --consumption-plan-location $location --storage-account $storageAccount --runtime dotnet --runtime-version 6 --functions-version 4 --os-type Windows

# Use Azure Functions Core Tools to create an Http triggered functions.
## Important: flags are case sensitive
func init --worker-runtime dotnet --source-control
func templates list
func new --name csharpfunc --language "C#" --template "HTTP trigger" --authlevel anonymous

# Publish to the function app in Azure
func azure functionapp publish $funcApp

# Run the function and check it (az rest)
curl $url