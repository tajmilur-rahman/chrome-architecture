## Replication Package for paper "The Modular and Feature Toggle Architectures of Google Chrome"
The following folders contain the code and mappings for each architecture we extracted.

### Conceptual Architecture folder
The conceptual architecture describes the major entities and relationships among those entities. We derive the conceptual architecture from the existing documentation for Google Chrome including the web resources and official wiki. The resource that we used and the final set of entity and edge mapping can be found in this folder. 

### Concrete Architecture folder
The concrete architecture is based on the source code files. We map the directories to the conceptual modules and then extract the call graph to the relationships between the modules. The folder contains the scripts to extract the Chrome source code files and directories, the resulting mappings in SQL, and the final mapping in CSV. 

### Reference Architecture folder
From our extracted extracted conceptual and concrete architectures of Chrome, we update the 12 year old browser reference architecture that was proposed by Grosskurth and Godfrey (2005). 

### Feature Toggles folder
The feature toggle architecture represents the feature toggle dependencies among the modules. Feature toggles are embedded in the source code files. Once we identify the feature toggles, we can assign feature dependencies among concrete and conceptual modules. We extract the feature toggle architecture of Chrome and illustrate the new couplings and relationships that are revealed by this new perspective 

The folder contains the source code to extract feature toggles from Chrome, the mappings between modules and features toggles, and the final feature architecture mapping.
