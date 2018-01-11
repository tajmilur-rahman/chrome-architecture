## Pre-requisites
1. Chrome source code downloaded from google-chrome repository (https://chromium.googlesource.com/chromium/src)
2. Understand software installation (https://scitools.com/trial-download-3/)
3. Understand API (https://scitools.com/feature/api/)

## Description of the folders and source files
### GitDag
This folder contains the Perl scripts to extract the Directed Acyclic Graph of Git commits. This gives us git tags and commit hashes. This allows us to checkout a particular release version.

### DependencyExtractor
This folder contains the scripts to extract and analyze the file dependencies. Basically this will give us the call-graph. The scripts are written based on Understand API. Inside the folder there are four files and one *lib* directory. The Program.cs is the main program file that contains the main method to run the code. The *DependencyAnalyzer.cs* file contains the methods to extract as well as analyze the dependencies. This file also contains methods to extract the toggle dependencies as well. For example: AnalyzeSwitchesDependenciesByFlagReferences(), AnalyzeSwitchesDependenciesByFiles().

### R
This folder contains the R scripts to generate the resulting figures. Inside this folder, the file *feature-module-module-feature.r* generates the figures for fiture span and the module span.
