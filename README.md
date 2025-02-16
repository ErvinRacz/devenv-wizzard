TODO: https://github.com/apps/desktop

Install the stack with chezmoi on Windows:

```
winget install --id Microsoft.PowerShell --source winget
```
&&
```
& {$env:DOTFILE_REPO_URL = "https://github.com/ErvinRacz/devenv-wizzard.git" ; iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '$env:USERPROFILE\.temp\bin' -- init --apply $env:DOTFILE_REPO_URL"}
```

Add chezmoi config to WSL:

```
DOTFILE_REPO_URL = "https://github.com/ErvinRacz/devenv-wizzard.git" ; chezmoi -- init --apply $DOTFILE_REPO_URL
```

Update on WSL Ubuntu with andsible:

```shell
wsl bash -c "cd $(( $env:USERPROFILE -replace '\\', '/' -replace 'C:/', '/mnt/c/' ) + '/.local/share/chezmoi/ansible') && ansible-playbook -K -i localhost, --connection=local ubuntu-installs.yaml"
```

add git hooks:

`ln -s ~/.git-global-hooks/commit-msg $(pwd)/.git/hooks/commit-msg`

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
