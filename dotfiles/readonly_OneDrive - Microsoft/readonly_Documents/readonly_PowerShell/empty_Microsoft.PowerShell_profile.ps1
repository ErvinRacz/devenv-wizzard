## Set PSReadLine options and keybindings
# $PSROptions = @{
#     ContinuationPrompt = '  '
#     Colors             = @{
#         Operator         = $PSStyle.Foreground.Magenta
#         Parameter        = $PSStyle.Foreground.Magenta
#         Selection        = $PSStyle.Background.BrightBlack
#         InLinePrediction = $PSStyle.Foreground.BrightYellow + $PSStyle.Background.BrightBlack
#     }
# }
# Set-PSReadLineOption @PSROptions
# Set-PSReadLineKeyHandler -Chord 'Ctrl+f' -Function ForwardWord
# Set-PSReadLineKeyHandler -Chord 'Enter' -Function ValidateAndAcceptLine


Invoke-Expression (&starship init powershell)