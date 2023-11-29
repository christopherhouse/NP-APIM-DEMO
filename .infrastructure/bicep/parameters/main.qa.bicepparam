using '../main.bicep'

param workloadPrefix = 'sz'
param workloadName = 'apim'
param environmentName = 'qa'
param location = 'eastus'
param apimSkuName = 'Developer'
param apimSkuCapacity = 1
param apimPublisherName = 'Publisher Name'
param apimPublisherEmail = 'zzz@zzyyzz.com'
param serviceBusSku = 'Standard'
param maxTopicSize = 2048
param ordersTopicName = 'received-orders'
param ordersTopicSubscriptionName = 'auto-approved-orders'
param ordersForApprovalSubscriptionName = 'orders-requiring-approval'
param ordersTopicSqlFilter = 'user.orderTotal <= 1000'
param ordersForApprovalSqlFilter = 'user.orderTotal >= 1000'
param fulfillmentTopicName = 'orders-for-fulfillment'
param keyVaultAdminIdentities = ['c9be89aa-0783-4310-b73a-f81f4c3f5407']
param cosmosDbDatabaseName = 'order-processing'
param ordersCosmosContainerName = 'orders'
param orderContainerPartitionKey = '/customerId'
param fulfillmentTopicSubscriptionName = 'all-approved-orders'
param shipmentTopicName = 'ready-for-shipment'
param shipmentTopicSubscriptionName = 'all-orders-for-shipment'
param cosmosLeaseContainerName = 'leases'
param statusNotificationTopicName = 'status-notifcations'
param statusNotificationTopicSubscriptionName = 'all-status-notifications'
param webHookNotificationUrl = 'https://webhook.site/cfa31dea-b33e-442f-b7d4-d52bcb8b4382/'
param sendApprovalTopicName = 'send-credit-approval'
param allCreditApprovalsSubscription = 'all-messages'
param pipelineServicePrincipalId = 'ff83a1e5-b4c1-4be3-a6dc-199514812166'
