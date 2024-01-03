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
    $apiVersionIdentifier,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $functionAppKeyKeyVaultSecretUri,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $userAssignedManagedIdentityClientId
)

$apiId = "productordering-$apiVersionIdentifier"

# Setup the APIM context to point to the correct RG and service
$apimContext = New-AzApiManagementContext -ResourceGroupName $resourceGroupName -ServiceName $apiManagementName

# Next, create a version set for the API
$versionSet = New-AzApiManagementApiVersionSet -Context $apimContext 
                                               -VersionSetId "productordering"
                                               -DisplayName "Product Ordering"
                                               -Description "Product Ordering"
                                               -Scheme Segment

# Then import the API from it's swagger doc and associate it to the version set
Import-AzApiManagementApi -Context $apimContext
                          -ApiId $apiId
                          -SpecificationFormat OpenApiJson
                          -SpecificationUrl "$functionAppUrl/api/swagger.json"
                          -Path "productordering"
                          -Protocols @("https")
                          -ApiType Http
                          -ApiVersionSetId $versionSet.ApiVersionSetId
                          -ApiVersion $apiVersionIdentifier

# Now we'll setup a backend that uses a keyvault backed named value for credentials.
# First, setup the kv reference
$kvSecret = New-AzApiManagementKeyVaultObject -SecretIdentifier $functionAppKeyKeyVaultSecretUri
                                              -IdentityClientId $userAssignedManagedIdentityClientId
# Create the named value, referencing the kv secret
$functionKeyNamedValue = New-AzureApimanagementnamedvalue -Context $apimContext
                                                          -NamedValueId "functionappkey"
                                                          -DisplayName "Function App Key"
                                                          -KeyVault $kvSecret
                                                          -Secret

# Now we create the backend creds that reference the named value
$backendCredentials = New-AzApiManagementBackendCredential -Header @{"x-functions-key" = @("{{FunctionAppKey}}")}

$backend = New-AzApiManagementBackend -Context $apimContext
                                      -BackendId "productordering-functions"
                                      -Url "$functionAppUrl/api"
                                      -Protocol Http
                                      -Title "Product Ordering Function App Backend"
                                      -Description "Product Ordering Function App Backend"
                                      -Credentials $backendCredentials
                                      -ResourceId $functionAppResourceId

$apiPolicyString = "<policies><inbound><base /><set-backend-service backend-id='funcapp' /></inbound></policies>"

Set-AzApiManagementApiPolicy -Context $apimContext
                             -ApiId $apiId
                             -Policy $apiPolicyString
