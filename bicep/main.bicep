param location string = resourceGroup().location

var shared = loadJsonContent('./modules/vars/runtime.json')
var condition = loadJsonContent('./conditional_deployment.json')

module rg_create './rg.bicep' = if (condition.rg_create == 'true') {
  name: 'resource-group'
  scope: subscription()
}

module stg './modules/storage-account/storage.bicep' = if (condition.stg == 'true') {
  name: 'Storage_Deployment'
  scope: resourceGroup('rg-${shared.name_prefix}-app01-${shared.short_location}-${shared.unique_stage}')
  params: {
    location: location
    storageAccountName: 'stdemoapp01${shared.unique_stage}'
  }
}

module log_analytics_and_application_insights './modules/monitoring/log-analytics-application-insights.bicep' = if (condition.log_analytics_and_application_insights == 'true') {
  name: 'log_analytics_and_application_insights'
  scope: resourceGroup('rg-${shared.name_prefix}-app01-${shared.short_location}-${shared.unique_stage}')
  dependsOn: [
    rg_create
  ]
}
