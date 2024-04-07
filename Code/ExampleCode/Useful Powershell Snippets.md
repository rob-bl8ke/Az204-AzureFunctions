# Useful Powershell Snippets

Get help with [Azure PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/azure/?view=azps-9.6.0) v9.6.0

Reference to Azure Functions Core Tools [at the command-line](https://learn.microsoft.com/en-us/azure/azure-functions/functions-core-tools-reference?tabs=v2). Here are some [full script examples](https://learn.microsoft.com/en-us/azure/azure-functions/create-resources-azure-powershell).

Use `Get-Command -AzResourceGroup` to find the commands for a specific item you might know something about. If we’re working with virtual machines so a good strategy would be to `Get-Command *-WebApp`.

```powershell
Connect-AzAccount
Disconnect-AzAccount

Get-Content csharpfunc.cs

# Create resource group and required standard SKU storage account
New-AzResourceGroup -Name robazresourcegroup -Location southafricanorth
Get-AzResource -ResourceGroupName robazresourcegroup | Format-Table
Get-AzResource -Name robazfuncappstorage -ResourceGroupName robazresourcegroup

Get-AzLocation | Format-Table Location, DisplayName
Get-AzLocation | Where-Object { $_.DisplayName -like "Canada" } | Format-Table Location, DisplayName

# Delete
Remove-AzResourceGroup -Name robazresourcegroup
```

```PowerShell
Get-Content .\typescriptfunc\index.ts
Get-AzResource -ResourceGroupName robazresourcegroup | Format-Table
Get-AzResource -Name robazfuncappstorage -ResourceGroupName robazresourcegroup
```

- [PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/azure/?view=azps-10.0.0&viewFallbackFrom=azps-9.6.0)