# dotnet

```sh

dotnet help

# dotnet new

dotnet new --list

dotnet new template --name MyName
dotnet new template --output MyName

dotnet new sln
dotnet new blazorserver
dotnet new blazorwasm
dotnet new webapi
dotnet new console
dotnet new worker
dotnet new mstest

dotnet new classlib
dotnet new razorclasslib

dotnet new editorconfig
dotnet new gitignore
dognet new razorcomponent
dotnet new webconfig

# dotnet sln

dotnet sln list
dotnet sln add -h
dotnet sln add path/to/project
dotnet sln remove path/to/project

# other stuff

dotnet build proj|sln
dotnet build proj|sln --no-incremental # rebuild
dotnet run --project path
dotnet run --configuration Debug|Release
dotnet watch


```