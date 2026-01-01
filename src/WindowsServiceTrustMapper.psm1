

Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -ErrorAction SilentlyContinue | ForEach-Object {
    . $_.FullName
}



Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -ErrorAction SilentlyContinue | ForEach-Object {
    . $_.FullName
}


Export-ModuleMember -Function 'Get-WstmServiceTrustMap'
