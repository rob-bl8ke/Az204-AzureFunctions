# Azure Functions Core Tools.

When creating a local function app and adding functions to it you’ll have to use Azure Functions Core Tools.

- `Get-Command New-AzFunc`.
- `func start` will start your function for debugging.

To set up Azure Function Core Tools you can use these commands to add functions globally. If you can’t find the tools installed globally in npm using npm list -g change your node version to 16 using nvm.

```bash
npm list -g # deprecated
npm list --location=global

npm uninstall -g azure-functions-core-tools
npm install -u -g azure-functions-core-tools@4
npm install -u -g azure-functions-core-tools@3

npm list -g # deprecated
npm list --location=global
```

### PowerShell

```powershell
New-AzFunctionApp `
    -Name $netfncapp `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -StorageAccountName $netfncstorage `
    -Runtime dotnet `
    -RuntimeVersion 6 `
    -FunctionsVersion 4 `
    -OSType Windows
```

```powershell
New-AzFunctionApp `
    -Name $nodefncapp `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -StorageAccountName $nodefncstorage `
    -Runtime node `
    -RuntimeVersion 16 `
    -FunctionsVersion 4 `
    -OSType Windows
```

### Publish using Tools

There isn't really anything in PowerShell... but you'll use the same commands for the Tools:

```bash
func init --worker-runtime dotnet --source-control false
func new --name csharpfunc --language "C#" --template "HTTP trigger" --authlevel anonymous
func azure functionapp publish $netfncapp
```

```bash
func init --worker-runtime node --language javascript --source-control false
func new --name javascriptfunc --language javascript --template "HTTP trigger" --authlevel anonymous --model V3
```

```bash
# Can test it in another terminal (if you do a "func start" you may not need need another terminal)
httprepl http://localhost:7071/api/javascriptfunc

```