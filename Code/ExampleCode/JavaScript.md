# JavaScript

```javascript
// From an incoming queue message that is a JSON object, 
// add fields and write to Table Storage
module.exports = async function (context, order) {
    order.PartitionKey = "Orders";
    order.RowKey = generateRandomId(); 

    context.bindings.order = order;
};

function generateRandomId() {
    return Math.random().toString(36).substring(2, 15) +
        Math.random().toString(36).substring(2, 15);
}
```
or...
```javascript
module.exports = async function (context, req) {
    context.log('JavaScript HTTP trigger function processed a request.');

    const name = (req.query.name || (req.body && req.body.name));
    const responseMessage = name
        ? "Hello, " + name + ". This HTTP triggered function executed successfully."
        : "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.";

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: responseMessage
    };
}
```

## `package.json`

```json
{
  "name": "",
  "version": "1.0.0",
  "description": "",
  "scripts": {
    "start": "func start",
    "test": "echo \"No tests yet...\""
  },
  "dependencies": {},
  "devDependencies": {
    "azure-functions-core-tools": "^4.x"
  }
}
```

## .funcignore

```
*.js.map
*.ts
.git*
.vscode
local.settings.json
test
getting_started.md
node_modules/@types/
node_modules/azure-functions-core-tools/
node_modules/typescript/
```