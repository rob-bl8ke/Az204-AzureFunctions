$resourcePrefix = "..."
$resourceGroup =  $resourcePrefix + "resourcegroup"
# $location = "eastus"
# $vm1 = $resourcePrefix + "vm1"

# Connect-AzAccount

# Stop-AzVM -Name $vm1 -ResourceGroupName $resourceGroup -Force
Remove-AzResourceGroup -Name $resourceGroup -Force