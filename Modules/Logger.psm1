
class Logger {
    [void]logMissingFile([string]$pathToLog) {
        $date = Get-Date -Format "MM-dd_HH-mm-ss"
        $fileName = "missing_$date.txt"

        if (! (Test-Path "./Logs"))  {
            New-Item -ItemType Directory -Path "./Logs"
        }

        "`"$pathToLog`" is missing" | Out-File -FilePath "./Logs/$fileName"
        Write-Host "Added missing file"
    }

}


Function New-Logger {
    [Logger]::new()
}

Export-ModuleMember -Function New-Logger