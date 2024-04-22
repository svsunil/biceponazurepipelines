targetScope = 'subscription'    // Resource group must be deployed under 'subscription' scope

var shared = loadJsonContent('./modules/vars/runtime.json')

resource rg  'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${shared.name_prefix}-app01-${shared.short_location}-${shared.unique_stage}'
  location: shared.location
  tags: shared.resourceTags
}
