param serviceName string
param location string
param skuName string
param skuCapacity int
param publisherEmail string
param publisherName string
param enableSystemAssignedManagedIdentity bool
param tags object

var identity = enableSystemAssignedManagedIdentity ? {
  type: 'SystemAssigned'
} : null

resource apiManagementService 'Microsoft.ApiManagement/service@2023-03-01-preview' = {
  name: serviceName
  location: location
  tags: tags
  identity: identity
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
}

output name string = apiManagementService.name
