Learn about DSC here:
https://www.youtube.com/watch?v=9HlM0xuu01M
https://learn.microsoft.com/en-us/windows/package-manager/configuration/create

Recommended DSC resources:
https://www.powershellgallery.com/packages
https://dsccommunity.org/


Look for a package:
`winget search nuget`

verify: `winget show --id <id>`

`winget upgrade`
`winget uninstall <name/id>`

`winget features`

Apply configuration as admin:
`winget configure .\dev-tools-config.dsc.yaml`

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


1. Install chezmoi
2. `New-Item -Path "C:\Workspace\devenv-wizzard" -ItemType SymbolicLink -Value "$env:USERPROFILE\.local\share\chezmoi"`
3. Install Config