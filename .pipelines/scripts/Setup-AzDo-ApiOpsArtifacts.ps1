[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty]
    [string]
    $AzDoOrgName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty]
    [string ]
    $AzDoProjectName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty]
    [string]
    $AzDoRepositoryName
)

