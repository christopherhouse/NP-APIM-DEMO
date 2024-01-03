[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]
    $resourceGroupName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]
    $apiManagementName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $functionAppUrl,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $functionAppResourceId,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $apiVersionIdentifier
)

# Setup the APIM context to point to the correct RG and service
$apimContext = New-AzApiManagementContext -ResourceGroupName $resourceGroupName -ServiceName $apiManagementName

# Next, create a version set for the API
$versionSet = New-AzApiManagementApiVersionSet -Context $apimContext 
                                               -VersionSetId "productordering"
                                               -DisplayName "Product Ordering"
                                               -Description "Product Ordering"
                                               -Scheme Segment

Import-AzApiManagementApi -Context $apimContext
                          -ApiId "productordering-$versionIdentifier"
                          -SpecificationFormat OpenApiJson
                          -SpecificationUrl "$functionAppUrl/api/swagger.json"
                          -Path "productordering"
                          -Protocols @("https")
                          -ApiType Http
                          -ApiVersionSetId $versionSet.ApiVersionSetId
                          -ApiVersion $apiVersionIdentifier
                          