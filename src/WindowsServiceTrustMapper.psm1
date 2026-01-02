

Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -ErrorAction SilentlyContinue | ForEach-Object {
    . $_.FullName
}



Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -ErrorAction SilentlyContinue | ForEach-Object {
    . $_.FullName
}


# Export all functions defined in public folder (by file base name)
$publicFunctions = Get-ChildItem -Path (Join-Path $PSScriptRoot 'public\*.ps1') -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty BaseName

Export-ModuleMember -Function $publicFunctions
