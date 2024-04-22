var shared = loadJsonContent('../vars/runtime.json')

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: 'log-${shared.name_prefix}-monitor-iac-${shared.short_location}-${shared.unique_stage}'
  location: shared.location
  tags: shared.resourceTags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${shared.name_prefix}-app01-iac-${shared.short_location}-${shared.unique_stage}'
  location: shared.location
  tags: shared.resourceTags  
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id

  }
}
