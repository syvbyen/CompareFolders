Import-Module (Resolve-Path "./Modules/CompareFolders.psm1") -Force

$compareFolders = New-CompareFolders

$compareFolders.run()