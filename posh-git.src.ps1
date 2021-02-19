# Add Git and associated utilities to the PATH
#
# NOTE: aliases cannot contain special characters, so we cannot alias
#       ssh-agent to 'ssh-agent'. The posh-git modules tries to locate
#       ssh-agent relative to where git.exe is, and that means we have
#       to put git.exe in the path and can't just alias it.
#
#
$Env:Path = "$Env:ProgramFiles\Git\bin" + ";" + $Env:Path

# Load post-git
#
# Push-Location (Resolve-Path "$Env:USERPROFILE\Documents\GitHub\posh-git")
Push-Location (Resolve-Path "C:\tools\poshgit\dahlbyk-posh-git-9bda399")

# Load posh-git module from current directory
#
# Import-Module .\posh-git
if (Test-Path -LiteralPath ($modulePath = Join-Path (Get-Location) (Join-Path src 'posh-git.psd1'))) {
    Import-Module $modulePath
}
else {
    Write-Host $modulePath
    throw "Failed to import posh-git."
}

# If module is installed in a default location ($Env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # # Reset color, which can be messed up by Enable-GitColors
    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    # Write-Host($pwd.ProviderPath) -nonewline
    Write-Host($pwd.ProviderPath)

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}

# Override some Git colors

$s = $global:GitPromptSettings
$s.LocalDefaultStatusForegroundColor    = $s.LocalDefaultStatusForegroundBrightColor
$s.LocalWorkingStatusForegroundColor    = $s.LocalWorkingStatusForegroundBrightColor

$s.BeforeIndexForegroundColor           = $s.BeforeIndexForegroundBrightColor
$s.IndexForegroundColor                 = $s.IndexForegroundBrightColor

$s.WorkingForegroundColor               = $s.WorkingForegroundBrightColor

Pop-Location

# Start the SSH Agent, to avoid repeated password prompts from SSH
#
# Start-SshAgent -Quiet
