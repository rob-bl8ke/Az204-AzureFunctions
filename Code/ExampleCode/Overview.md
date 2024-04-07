
# Create Triggers and Bindings

- https://learn.microsoft.com/en-us/training/modules/develop-azure-functions/3-create-triggers-bindings

### functions.json

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
