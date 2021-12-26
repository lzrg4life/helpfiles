# Node Quickstart

## Setup

```sh
mkdir myproject
cd myproject

git init
npm init -y

# Standard stuff I always use
npm install --save-dev typescript
npm install --save-dev @types/node
npm install --save-dev tslint

touch .gitignore
touch tsconfig.json
touch tslint.json
```

Add the following script to the package.json:

```json
"compile": "npx tsc"
```

.gitignore contents:

```gitignore
**/node_modules/*
dist/*
.env
```

tsconfig contents:

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

tslint contents:

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

## Building projects

These section is about using node scripts for building a project.

```sh
npm install --save-dev shelljs      # Execute shell commands
npm install --save-dev fs-extra     # Extends the node fs module
npm install --save-dev rimraf       # Recursively remove folders
npm install --save-dev npm-run-all  # Run multiple npm scripts
npm install --save-dev ts-node      # Run TS files directly in node

npm install --save-dev @types/fs-extra 
npm install --save-dev @types/shelljs
npm install --save-dev tslib @types/node
```

To run a TypeScript file directly using ts-node:
```sh
npx ts-node file.ts
```

Using shelljs, you can run basically any unix shell command on windows/mac/linux

Example to copy all none-TS files from src to dist
```typescript
import shell from 'shelljs'

//shell.rm('-rf', 'dist');
shell.cp('-Ru', 'src/*.!(ts)');
```

To copy all none-ts files to dist 