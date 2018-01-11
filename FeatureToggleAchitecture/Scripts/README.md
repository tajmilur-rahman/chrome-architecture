## Feature Toggle Architecure Extraction

### Pre-Requisite
1. Extract Conceptual and Concrete Architecture

### Steps
1. Find out all the *\*_switches.cc* files in the Chrome source dir.
2. Use the [dependency extractor](https://github.com/tajmilur-rahman/chrome-architecture/tree/master/ConcreteAchitecture/Scripts/DependencyExtractor) to extract and analyze the file that are using feature toggles.
3. Using the toggle dependencies we filter out the [Mappings](https://github.com/tajmilur-rahman/chrome-architecture/tree/master/ConcreteAchitecture/Mapping) that we obtained in the Concrete Architecture and finally we come up with feature-module dependencies.
4. We use the [Graph Editor](https://csacademy.com/app/graph_editor) to visualize the feature toggle architectural view from the feature-module dependencies.
