@{
    RootModule        = 'WindowsServiceTrustMapper.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = 'd8c4d9f1-6a9b-4c10-9f6d-2c3b9a9c1f01'
    Author            = 'Martino Sani'
    Description       = 'A PowerShell module to map Windows services trust boundaries (paths, permissions, execution context).'
    PowerShellVersion = '5.1'

    FunctionsToExport = '*'

    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}
