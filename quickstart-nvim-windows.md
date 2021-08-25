# Quickstart: Neovim on Windows

## Prerequisites

nodejs >= 12.12 (for conquer of completion)

## "Install" it

[Download the Neovim win64 zip file for the latest release](https://github.com/neovim/neovim/releases)

Extract the file to `C:\tools\Neovim` such that `nvim.exe` is at `C:\tools\Neovim\bin\nvim.exe`

## Create powershell aliases

Create aliases in your powershell `$PROFILE`.

```powershell
New-Alias -name "v" "C:\tools\Neovim\bin\nvim.exe"
New-Alias -name "vq" "C:\tools\Neovim\bin\nvim-qt.exe"
VPROFILE = "$HOME\AppData\Local\nvim\init.vim"
```

## Set up init.vim

If you need to check where to put the init.vim file, run nvim.exe and do
`:help init` and locate the line that says where the init file goes for Windows.

Create the file

```powershell
New-Item -Force "$HOME\AppData\Local\nvim\init.vim"
```

## Set up vim-plug

Refer to the steps [in the official repo](https://github.com/junegunn/vim-plug)

Download the file to the correct location

```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

Add the following to `init.vim`

```vim
call plug#begin(stdpath('data') . '/plugged')

Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
```

Close neovim and reopen it

Then do `:PlugInstall` and close and reopen neovim

Then do `:CocInstall coc-json` since it seems to be needed for some others to
work right

Then close neovim

Now symlink the `./more/init.vim` file to the neovim profile location:

```powershell
# in an admin powershell opened in the root of this repo
Remove-Item $VPROFILE
New-Item -ItemType SymbolicLink -Path $VPROFILE -Target $PWD\more\init.vim 
```

## Setup Conquer of Completion

Refer to the list of all extensions [here](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions)

```vim
:CocInstall coc-diagnostic coc-highlight
:CocInstall coc-tsserver coc-css coc-html coc-htmlhint coc-html-css-support coc-emmet
:CocInstall coc-markdownlint coc-powershell coc-sql

:CocInstall coc-viml coc-xml coc-yaml
```

## Add to explorer context menu

Open regedit.exe

For folders: `HKEY_CURRENT_USER\Software\Classes\directory\shell`
For files: `HKEY_CURRENT_USER\Software\Classes\*\shell`

1. Create a new key under "shell"
2. Create a new key under (1) named `command`
3. Set the `default` property of (2) to be `path\to\exe "%1"`
4. (optional) Add a string value named icon under (1) with a value that is a
path to an icon
