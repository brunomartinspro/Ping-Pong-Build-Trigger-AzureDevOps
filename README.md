# Ping Pong Build Trigger AzureDevOps Extension

Find the main source code in https://github.com/brunomartinspro/Ping-Pong-Build-Trigger

# Yaml Example
```
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
```
# How to use it
[![How it works](https://i.imgur.com/03PlVDw.png)](http://www.youtube.com/watch?v=kHauYihebYU "Ping Pong Build Trigger - How to use it")

![alt text](Extension/extensionIcon.png)
