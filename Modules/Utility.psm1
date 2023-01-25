class Utility {
    [string]folderBrowserDialog([string]$description) {
        Add-Type -AssemblyName System.Windows.Forms
        $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderBrowser.Description = $description

        if ($folderBrowser.ShowDialog() -eq "OK") {
            return $folderBrowser.SelectedPath
        }

        return "Nothing"
    }
}

Function New-Utility {
    [Utility]::new()
}

Export-ModuleMember -Function New-Utility