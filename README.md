# Replication Package for Extracting Feature Toggle View of Google Chrome Browser Architecture

## Pre-requisites
1. Chrome source code downloaded from google-chrome repository (https://chromium.googlesource.com/chromium/src)
2. Understand software installation (https://scitools.com/trial-download-3/)
3. Understand API (https://scitools.com/feature/api/)

## Directories and Files
### Conceptual
This folder contains the documentations and research papers we studied to construct the conceptual architecture

### Concrete
This folder contains the (module-module) mapping document and the scripts that we used for constructing the concrete architecture.
#### Mapping
The csv file in this folder contains the module-module relationships and the strength of each relationship in terms of number of calls.
#### Scripts
This folder contains sub-directories R - for r scripts, git_dag - for the scripts to traverse through the git commit-tree. 
It also contains the sql scripts for file-file, direcroty-module and module-module relationships.
