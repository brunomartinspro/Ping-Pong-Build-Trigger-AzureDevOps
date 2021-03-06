# Ping Pong Build Trigger AzureDevOps Extension

Randomly trigger builds to find a sequenced build order

- Find the main source code in https://github.com/brunomartinspro/Ping-Pong-Build-Trigger
- Find the extension source code in https://github.com/brunomartinspro/Ping-Pong-Build-Trigger-AzureDevOps

## Features
- Parallel Builds
- Sequence Builds
- Output Sequence
- Ignores DevOps builds

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

## Use case

Having separate repositories that have an order that needs to be built with an exact order, this program triggers builds first in parallel order:

## Fist parallel loop

1. A - OK
2. B - FAIL
3. C - FAIL
4. D - FAIL
5. E - FAIL
6. F - OK
7. G - FAIL
8. H - FAIL
9. J - OK

## Second parallel loop

2. B - FAIL
3. C - OK
4. D - OK
5. E - FAIL
7. G - OK
8. H - FAIL

## Third parallel loop

2. B - OK
5. E - OK
8. H - OK

## Sequence generated by loops

1. A
2. F
3. J
4. C
5. D
6. G
7. B
8. H
9. E

The next time the program runs it will use this sequence and run the builds sequentially but if there are new builds after ending the sequence it will run in parallel the new builds and generate a new sequence.