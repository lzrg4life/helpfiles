# Quickstart: Node with TypeScript

This will get you set up with node, express and typescript.

This is a summary of [this developer.okta blog post](https://developer.okta.com/blog/2018/11/15/node-express-typescript)

# Initial Prep

Have a current version of node/npm installed.

Make an empty directory for your project and open a terminal there.

```sh
mkdir myproject
cd myproject

npm init -y

npm install express     # web server framework
npm install dotenv      # easily manage environment variables

npm install --save-dev nodemon      # auto-restart node
npm install --save-dev typescript
npm install --save-dev tslint
npm install --save-dev shelljs      # Execute shell commands
npm install --save-dev fs-extra     # Extends the node fs module
npm install --save-dev rimraf       # Recursively remove folders
npm install --save-dev npm-run-all  # Run multiple npm scripts

npm install --save-dev @types/node 
npm install --save-dev @types/express
npm install --save-dev @types/fs-extra 
npm install --save-dev @types/shelljs
npm install --save-dev @types/dotenv

mkdir tools
mkdir dist
mkdir src
mkdir src/views
mkdir src/routes

touch .env  # do not include this in version control
touch .gitignore
touch tsconfig.json
touch tslint.json
touch tools/copyAssets.ts
touch src/index.ts
touch src/views/index.ejs
touch src/routes/index.ts
```

## tsconfig.json

```json
{
    "compilerOptions": {
        "module": "commonjs",
        "esModuleInterop": true,
        "target": "es6",
        "noImplicitAny": true,
        "moduleResolution": "node",
        "sourceMap": true,
        "outDir": "dist",
        "baseUrl": ".",
        "paths": {
            "*": [
                "node_modules/*"
            ]
        }
    },
    "include": [
        "src/**/*"
    ]
}
```

## tslint.json

```json
{
    "defaultSeverity": "error",
    "extends": [
        "tslint:recommended"
    ],
    "jsRules": {},
    "rules": {
        "trailing-comma": [ false ]
    },
    "rulesDirectory": []
}
```

## package.json

```json
"main": "dist/index.js"
 "scripts": {
    "clean": "rimraf dist/*",
    "copy-assets": "ts-node tools/copyAssets",
    "lint": "tslint -c tslint.json -p tsconfig.json --fix",
    "tsc": "tsc",
    "build": "npm-run-all clean lint tsc copy-assets",
    "dev:start": "npm-run-all build start",
    "dev": "nodemon --watch src -e ts,ejs --exec npm run dev:start",
    "start": "node .",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```

## src/index.ts

```ts
import dotenv from "dotenv";
import express from "express";
import path from "path";

// initialize configuration
dotenv.config();

// port is now available to the Node.js runtime 
// as if it were an environment variable
const port = process.env.SERVER_PORT;

const app = express();

// Configure Express to use EJS
app.set( "views", path.join( __dirname, "views" ) );
app.set( "view engine", "ejs" );

// define a route handler for the default home page
app.get( "/", ( req, res ) => {
    // render the index template
    res.render( "index" );
} );

// start the express server
app.listen( port, () => {
    // tslint:disable-next-line:no-console
    console.log( `server started at http://localhost:${ port }` );
} );
```

## src/views/index.ejs

```ejs
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Guitar Inventory</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
    <div class="container">
        <h1 class="header">Guitar Inventory</h1>
        <a class="btn" href="/guitars"><i class="material-icons right">arrow_forward</i>Get started!</a>
    </div>
</body>
</html>
```

## tools/copyAssets.ts

```ts
import * as shell from "shelljs";

// Copy all the view templates
shell.cp( "-R", "src/views", "dist/" );
```

## .env 

```env
# Set to production when deploying to production
NODE_ENV=development

# Node.js server configuration
SERVER_PORT=8080
```

## .gitignore

```gitignore
**/node_modules/*
dist/*
.env
```

## src/routes/index.ts

```ts
import * as express from "express";

export const register = ( app: express.Application ) => {
    const oidc = app.locals.oidc;

    // define a route handler for the default home page
    app.get( "/", ( req: any, res ) => {
        res.render( "index" );
    } );

    // define a secure route handler for the login page that redirects to /guitars
    app.get( "/login", oidc.ensureAuthenticated(), ( req, res ) => {
        res.redirect( "/guitars" );
    } );

    // define a route to handle logout
    app.get( "/logout", ( req: any, res ) => {
        req.logout();
        res.redirect( "/" );
    } );

    // define a secure route handler for the guitars page
    app.get( "/guitars", oidc.ensureAuthenticated(), ( req: any, res ) => {
        res.render( "guitars" );
    } );
};
```