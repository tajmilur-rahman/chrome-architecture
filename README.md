# Replication Package for Extracting Feature Toggle View of Google Chrome Browser Architecture 

## Pre-requisites
1. Chrome source code downloaded from google-chrome repository (https://chromium.googlesource.com/chromium/src)
2. Understand software installation (https://scitools.com/trial-download-3/)
3. Understand API (https://scitools.com/feature/api/)

## Directories and Files
1. replicate/R - Contains all the R scripts for generating figures
2. replicate/feature-files5 - Contains list of files use feature toggles. Each file represents each toggle set at version 5.0
3. replicate/feature-files13 - Contains list of files use feature toggles. Each file represents each toggle set at version 13.0
4. replicate/feature-files22 - Contains list of files use feature toggles. Each file represents each toggle set at version 22.0
5. replicate/feature-files34 - Contains list of files use feature toggles. Each file represents each toggle set at version 34.0
6. replicate/git_dag - Contains the scripts for traversing through the git commit-tree
7. replicate/reports - Contains the raw results during our research
