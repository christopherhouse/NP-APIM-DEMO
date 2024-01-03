[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]
    $armOutputString
)

Write-Output "Deployment output is $armOutputString"
$outputObj = $armOutputString | ConvertFrom-Json
$functionAppName = $outputObj.functionAppName.value
$keyVaultName = $outputObj.keyVaultName.value
$functionAppHostName = $outputObj.functionAppHostName.value
$apimName = $outputObj.apimName.value
$functionAppResourceId = $outputObj.functionAppResourceId.value
$apimUserAssignedManagedIdentityClientId = $outputObj.apimUserAssignedManagedIdentityClientId.value

Write-Output "##vso[task.setvariable variable=functionAppName;]$functionAppName"

Write-Output "##vso[task.setvariable variable=keyVaultName;]$keyVaultName"

Write-Output "##vso[task.setvariable variable=functionAppHostName;]$functionAppHostName"

Write-Output "##vso[task.setvariable variable=apimName;]$apimName"

Write-Output "##vso[task.setvariable variable=functionAppResourceId;]$functionAppResourceId"

Write-Output "##vso[task.setvariable variable=apimUserAssignedManagedIdentityClientId;]$apimUserAssignedManagedIdentityClientId"