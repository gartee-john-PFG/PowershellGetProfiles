# Start a transcript
#
if (!(Test-Path "$Env:USERPROFILE\Documents\WindowsPowerShell\Transcripts"))
{
    if (!(Test-Path "$Env:USERPROFILE\Documents\WindowsPowerShell"))
    {
        $rc = New-Item -Path "$Env:USERPROFILE\Documents\WindowsPowerShell" -ItemType directory
    }
    $rc = New-Item -Path "$Env:USERPROFILE\Documents\WindowsPowerShell\Transcripts" -ItemType directory
}
$curdate = $(get-date -Format "yyyyMMddhhmmss")
Start-Transcript -Path "$Env:USERPROFILE\Documents\WindowsPowerShell\Transcripts\PowerShell_transcript.$curdate.txt"
