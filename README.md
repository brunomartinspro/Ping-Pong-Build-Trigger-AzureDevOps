# Ping-Pong-Build-Trigger-AzureDevOps
Extension for Azure DevOps

Find the main source code in https://github.com/brunomartinspro/Ping-Pong-Build-Trigger

# Yaml Example
steps:
- task: ping-pong-build-trigger@1
  inputs:
    mode: 'AzureDevOps'
    apiKey: 'asd'
    source: 'http://kamina.azuredevops.local/DefaultCollection/Kamina'
    projectName: 'Kamina'
    sourceBranch: 'develop'
    lastKnownFile: ''
    maxErrorCycles: 6
    infiniteCycles: 'false'
