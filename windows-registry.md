# Windows Registry

## Hiding/Showing the restart option:

Reference: https://www.top-password.com/blog/hide-shutdown-or-restart-from-windows-10-sign-in-screen/#:~:text=1%20Open%20Registry%20Editor%20and%20navigate%20to%20one,OK%20.%20...%203%20Close%20Registry%20Editor.%20

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Start\HideRestart
```

Edit the registry key, setting "value" to 1 for true or 0 for false.

## Windows Explorer Context Menu options

See the `examples\WindowsContextMenus.reg` file for examples adding powershell core and sublime text menu items.

Reference: https://stackoverflow.com/questions/20449316/how-add-context-menu-item-to-windows-explorer-for-folders

1. Under 'shell' add a key with a name for the context menu item.
2. Modify the default value under the key created in step 1 to be the display name
2. Under the key added in 1, add a key with name "command" 
3. Modify the default value in the "command" key, setting the value to the CLI command to run.

In commands, `%V` is a placeholder for the full folder/file path

Example commands:

```
"C:\\Program Files\\PowerShell\\7\\pwsh.exe -NoExit -Command Set-Location -LiteralPath '%V'"
"C:\\Program Files\\Sublime Text\\sublime_text.exe '%V'"
```

### To add an icon

1. Alongside the "command" key, add a string value named "icon"
2. Modify the default value to point to an icon resource. Optionally provide an integer to specify the icon

Example:

```
%SystemRoot%\System32\shell32.dll,3
```

### Display only on shift-click

1. Alongside the "command" key, add an empty string value named "Extended"

### Change menu entry location

1. Add a string value named "Position" with a value of either "Top" or "Bottom"

### Background Context Menu 

admin: `HKEY_CLASSES_ROOT\Directory\Background\shell`
user: `HKEY_CURRENT_USER\Software\Classes\directory\Background\shell`

### Folder Context Menu

admin: `HKEY_CLASSES_ROOT\Directory\shell`
user: `HKEY_CURRENT_USER\Software\Classes\directory\shell`

### File Context Menu

admin: `HKEY_CLASSES_ROOT\*\shell`
user: `HKEY_CURRENT_USER\Software\Classes\*\shell`

### Drive Context Menu

admin: `HKEY_CLASSES_ROOT\Drive\shell`

## Hiding existing context menu items

Add an empty string value named "Extended" to the key under the `shell` "folder"

