$resourceGroup = "...resourcegroupjs2"
$location = "eastus"
$storageAccount = "...jsfuncstorage"
$funcApp = "...javascriptfuncapp"
$url = "https://$funcApp.azurewebsites.net/api/csharpfunc?name=..."

# Check if you're logged in to Azure
if (-not (Get-AzContext -ErrorAction SilentlyContinue)) {
  # If you're not logged in, perform az login
  az login
} else {
  # If you're logged in, display a message
  Write-Host "You're already logged in to Azure as $((Get-AzContext).Account.Id)."
}

# Create resource group and required standard SKU storage account
New-AzResourceGroup -Name $resourceGroup -Location $location

New-AzStorageAccount -Name $storageAccount -Location $location -ResourceGroupName $resourceGroup -SkuName Standard_LRS -AllowBlobPublicAccess $false

# Create the function app
New-AzFunctionApp -Name $funcApp `
  -ResourceGroupName $resourceGroup `
  -Location $location `
  -StorageAccountName $storageAccount `
  -Runtime "node" `
  -RuntimeVersion "16" `
  -FunctionsVersion "4" `
  -OsType "Windows"

# Use Azure Functions Core Tools to create an Http triggered functions.
## Important: flags are case sensitive
func init --worker-runtime node --language javascript --source-control
# func templates list
func new --name javascriptfunc --language javascript --template "HTTP trigger" --authlevel anonymous --model V3

# Build and start the function running locally.
npm i
npm run build
npm start

# Can test it in another terminal (if you do a "func start" you may not need need another terminal)
curl http://localhost:7071/api/javascriptfunc

# Publish to the function app in Azure
func azure functionapp publish $funcApp

# Run the function and check it (az rest)
curl $url
