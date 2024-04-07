# Azure Functions

## Run and debug on Local Machine (using Visual Studio Code)
Install
- [C# for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
- [Azure Core Functions Tools](https://github.com/Azure/azure-functions-core-tools#installing)
- [Azure Functions Extension (for VS Code)](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)


## Overview

- Config is generated automatically for compiled languages based on code annotations.
- In scripting languages, the files are manually implemented.

### functions.json

- Defines trigger, bindings and outputs.
- May also define some other configuration settings.

> The definitions below identifies a Queue Storage trigger with a connection string and a single output binding to a Azure Table Storage resource. `$return` refers to the function return value.

- [Source](https://learn.microsoft.com/en-us/training/modules/develop-azure-functions/3-create-triggers-bindings)

```json
{
    "bindings": [
        {
            "type": "queueTrigger",
            "direction": "in",
            "name": "order",
            "queueName": "my-queue-items",
            "connection": "MY_STORAGE_ACCT_APP_SETTING"
        },
        {
            "type": "table",
            "direction": "out",
            "name": "$return",
            "queueName": "outTable",
            "connection": "MY_TABLE_STORAGE_ACCT_APP_SETTING"
        }
    ]
}
```

- Both triggers and bindings are configured on the "bindings" property.
- Use type, direction, an name are (at miminal) required to define them.

Each binding defines a type (`httpTrigger`, `queueTrigger`) data type (binary, string, ...), name, and direction (`in`, `out`, `inout`)
```json
{
    "dataType": "binary",
    "type": "httpTrigger",
    "name": "req",
    "direction": "in"
}
```

### Connect Functions to Services

A trigger definition might include a connection property but you can't set the connection string directly in `function.json`. You can set it to:
- An environment variable that contains the connection string ([Application Settings](https://learn.microsoft.com/en-us/azure/azure-functions/functions-how-to-use-azure-function-app-settings?tabs=portal#settings)).
- A [local settings file](https://learn.microsoft.com/en-us/azure/azure-functions/functions-develop-local#local-settings-file) (appsettings.json).
- A [managed identity](https://learn.microsoft.com/en-us/azure/app-service/overview-managed-identity?toc=%2Fazure%2Fazure-functions%2Ftoc.json&tabs=portal%2Chttp).


### hosts.json

- Contained in the root folder and contains runtime specific configuration.


### Local Development

- Functions can be [coded locally](https://learn.microsoft.com/en-us/azure/azure-functions/functions-develop-local) using various editors (Visual Studio Code, Visual Studio) using the [Azure Functions Core Tools](https://www.npmjs.com/package/azure-functions-core-tools).
- Can be debugged using the full Functions runtime.

- [Connect to Azure services in app code](https://learn.microsoft.com/en-us/azure/app-service/overview-managed-identity?toc=%2Fazure%2Fazure-functions%2Ftoc.json&tabs=portal%2Chttp)

# References

- [Azure Function Development Overview](https://learn.microsoft.com/en-us/training/modules/develop-azure-functions/2-azure-function-development-overview)