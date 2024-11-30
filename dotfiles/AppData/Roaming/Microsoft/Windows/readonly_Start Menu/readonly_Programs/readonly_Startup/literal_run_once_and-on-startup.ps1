$chezmoiSourcePath = & chezmoi source-path

# Function to start and configure watchman
function Start-WatchmanForChezmoi {
    # Start watching the chezmoi source path
    Write-Host "Setting up watchman for path: $chezmoiSourcePath"
    & watchman watch $chezmoiSourcePath

    # Define the trigger for 'chezmoi apply --force'
    $triggerConfig = @"
[
    "trigger", "$chezmoiSourcePath", {
        "name": "chezmoi-apply",
        "command": ["chezmoi", "apply", "--force"]
    }
]
"@
    Write-Host "Configuring watchman trigger for chezmoi apply..."
    & watchman -j $triggerConfig
}

Start-WatchmanForChezmoi