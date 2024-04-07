
$resourcePrefix = "..."
$resourceGroup =  $resourcePrefix + "resourcegroup"
$location = "eastus"

$netfncstorage = $resourcePrefix + "dotnetfncstorage"
$netfncapp = $resourcePrefix + "dotnetfncapp"
$nodefncstorage = $resourcePrefix + "nodefncstorage"
$nodefncapp = $resourcePrefix + "nodefncapp"

$scriptFolder = $PSScriptRoot
$folderPath = "..."

# Connect-AzAccount
# $Credential = Get-Credential
# Connect-AzAccount -Credential $Credential 
# (Get-AzContext).Account

New-AzResourceGroup -Name $resourceGroup -Location $location

# <# .................................................
#     .NET Function App
#     - Build and publish functions
# ................................................. #>
New-AzStorageAccount `
    -Name $netfncstorage  `
    -Location $location `
    -ResourceGroupName $resourceGroup `
    -SkuName Standard_LRS

New-AzFunctionApp `
    -Name $netfncapp `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -StorageAccountName $netfncstorage `
    -Runtime dotnet `
    -RuntimeVersion 6 `
    -FunctionsVersion 4 `
    -OSType Windows

New-AzStorageAccount `
    -Name $nodefncstorage  `
    -Location $location `
    -ResourceGroupName $resourceGroup `
    -SkuName Standard_LRS

New-AzFunctionApp `
    -Name $nodefncapp `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -StorageAccountName $nodefncstorage `
    -Runtime node `
    -RuntimeVersion 16 `
    -FunctionsVersion 4 `
    -OSType Windows
try {
    # .NET
    $dotnetFuncFolder = Join-Path -Path $folderPath -ChildPath "dotnetfunc"

    if (-not (Test-Path $dotnetFuncFolder -PathType Container)) {
        New-Item -ItemType Directory -Path $dotnetFuncFolder -Force | Out-Null
        cd $dotnetFuncFolder
        func init --worker-runtime dotnet --source-control false
        func new --name csharpfunc --language "C#" --template "HTTP trigger" --authlevel anonymous
        func azure functionapp publish $netfncapp
        cd $folderPath
        Remove-Item -Path $dotnetFuncFolder -Recurse -Force
    }

    # Node
    $nodeFuncFolder = Join-Path -Path $folderPath -ChildPath "dotnetfunc"

    if (-not (Test-Path $nodeFuncFolder -PathType Container)) {
        New-Item -ItemType Directory -Path $nodeFuncFolder -Force | Out-Null
        cd $nodeFuncFolder
        func init --worker-runtime node --language javascript --source-control false
        func new --name javascriptfunc --language javascript --template "HTTP trigger" --authlevel anonymous --model V3
        npm i
        npm build
        func azure functionapp publish $nodefncapp
        cd $folderPath
        Remove-Item -Path $nodeFuncFolder -Recurse -Force
    }

} catch {
  Write-Host "An error occurred:"
  Write-Host $_.ScriptStackTrace
} finally {
    cd $scriptFolder
}