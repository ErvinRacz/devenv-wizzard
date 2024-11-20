
`$env:WORKSPACE_PATH = "C:\Workspace" ; & {$env:DOTFILE_REPO_URL = "https://github.com/ErvinRacz/devenv-wizzard.git" ; iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '$env:TEMP\bin' -- init --apply $env:DOTFILE_REPO_URL"}`

2. `New-Item -Path "C:\Workspace\devenv-wizzard" -ItemType SymbolicLink -Value "$env:USERPROFILE\.local\share\chezmoi"`
3. Install Config





## 2. Install Edge Extensions:
- https://github.com/gdh1995/vimium-c
- https://github.com/gorhill/uBlock

### 3. Add keybinding to vimium:

```
map <c-d> scrollDown
map <c-u> scrollUp
map <c-i> goForward
map <c-o> goBack
```


to learn more:

Learn about DSC here:
https://www.youtube.com/watch?v=9HlM0xuu01M
https://learn.microsoft.com/en-us/windows/package-manager/configuration/create

Recommended DSC resources:
https://www.powershellgallery.com/packages
https://dsccommunity.org/


Look for a package:
`winget search neovim`

verify: `winget show --id <id>`

`winget upgrade`
`winget uninstall <name/id>`
`winget features`

`winget configure .\dev-tools-config.dsc.yaml`