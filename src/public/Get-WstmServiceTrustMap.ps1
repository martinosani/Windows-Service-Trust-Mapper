

function Get-WstmServiceTrustMap {
    <#
    .SYNOPSIS
    Retrieves the trust map of Windows services.

    .DESCRIPTION
    This function scans the Windows services on the local machine and retrieves their trust levels based on predefined criteria.

    .EXAMPLE
    Get-WstmServiceTrustMap

    Retrieves the trust map of all Windows services on the local machine.

    .OUTPUTS
    A custom object containing service names and their corresponding trust levels.
    #>

    [CmdletBinding()]
    param (
        # Filtered by service name.
        [string]$ServiceName,

        # Include disabled services in the assessment.
        [switch]$IncludeDisabled
    )

    $services = Get-CimInstance Win32_Service

    if (-not $IncludeDisabled) {
        $services = $services | Where-Object { $_.StartMode -ne 'Disabled' }
    }

    if ($ServiceName) {
        $services = $services | Where-Object { $_.Name -like "*$ServiceName*" }
    }

    $report = foreach ($service in $services) {
        [PSCustomObject]@{
            ServiceName = $service.Name
            DisplayName = $service.DisplayName
            State       = $service.State
            StartMode   = $service.StartMode
        }
    }


    return $report
}