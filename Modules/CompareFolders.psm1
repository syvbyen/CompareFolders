Import-Module (Resolve-Path "$PSScriptRoot/Utility.psm1") -Force
Import-Module (Resolve-Path "$PSScriptRoot/Logger.psm1") -Force

class CompareFolders {
    [string]$originalRoot
    [string]$targetRoot
    [PSCustomObject]$utility
    [PSCustomObject]$logger
    [bool]$debug

    CompareFolders([PSCustomObject] $utility, [PSCustomObject] $logger) {
        $this.utility = $utility
        $this.logger = $logger
        $this.debug = $false
    }

    [void]setOriginalRoot() {
        if ($this.debug) {
            $this.originalRoot = "./original"
        } else {
            $this.originalRoot = $this.utility.folderBrowserDialog("Velg den originale mappen")
        }
    }

    # Set TargetFolderRootPath
    [void]setTargetRoot() {
        if ($this.debug) {
            $this.targetRoot = "./target"
        } else {
            $this.targetRoot = $this.utility.folderBrowserDialog("Velg den mappen du skal sjekke")
        }
    }

    [string]makePathRelative([string]$rootPath, [string]$fullPath) {
        return ($fullPath.toString()).replace((Resolve-Path $rootPath).toString(), '')
    }

    # Loop through original and compare to Target
    [void]compareOriginalAndTarget() {
        $originalItems = Get-ChildItem -Path $this.originalRoot -Recurse
        $counter = 0


        foreach ($path in $originalItems) {
            $relativePath = $this.makePathRelative($this.originalRoot, $path)
            $targetPath = Join-Path -Path $this.targetRoot -ChildPath $relativePath


            if (! (Test-Path $targetPath)) {
                $this.logger.logMissingFile($relativePath)
                $counter++
            }
        }
        if ($counter -Eq 0) {
            Write-Host -ForegroundColor White -BackgroundColor DarkGreen "No files were missing"
        }
    }

    [void]run() {
        $this.setOriginalRoot()
        $this.setTargetRoot()
        $this.compareOriginalAndTarget()
    }
}

Function New-CompareFolders {
    $utility = New-Utility
    $logger = New-Logger
    [CompareFolders]::new($utility, $logger)
}


Export-ModuleMember -Function New-CompareFolders