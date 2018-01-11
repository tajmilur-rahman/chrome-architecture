## Feature Toggle Architecture
The feature toggle architecture represents the feature toggle dependencies among the modules. The source folder contains the code to extract feature toggles from Chrome. The file *FatureArchitecturalViewRel34.pdf* contains the figure for the feature toggle architectural view of Google Chrome 34th release version. 

### Pre-Requisite
Extract Conceptual and Concrete Architecture

### Mappings Folder
1. The mappings between the feature set and Chrome source files is found in the dirrectories *ToggleSetFilesV#*
2. The feature toggle dependency between files can be found in the *ToggleDependenciesByFileV#.xlsx* files.

### Steps
1. Find out all the *\*_switches.cc* files in the Chrome source dir.
2. Use the [dependency extractor](https://github.com/tajmilur-rahman/chrome-architecture/tree/master/ConcreteAchitecture/Scripts/DependencyExtractor) to extract and analyze the file that are using feature toggles.
3. Using the toggle dependencies we filter out the [Mappings](https://github.com/tajmilur-rahman/chrome-architecture/tree/master/ConcreteAchitecture/Mapping) that we obtained in the Concrete Architecture and finally we come up with feature-module dependencies.
4. We use the [Graph Editor](https://csacademy.com/app/graph_editor) to visualize the feature toggle architectural view from the feature-module dependencies.
