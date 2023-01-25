
class Logger {
    [void]logMissingFiles([System.Object[]]$pathsToLog) {
        $date = Get-Date -Format "MM-dd_HH-mm-ss"
        $fileName = "missing_$date.txt"

        if (! (Test-Path "./Logs"))  {
            New-Item -ItemType Directory -Path "./Logs"
        }

        $pathsToLog | Out-File -FilePath "./Logs/$fileName"
        Write-Host "Added missing files to file $fileName"
    }

}


Function New-Logger {
    [Logger]::new()
}

Export-ModuleMember -Function New-Logger