## Concrete Architecture
The concrete architecture is derived from manually mapping the source code directories to the conceptual modules. 

###The mapping folder contains postgres sql files for
1. The call graph mapping between files (file_file_relation.sql)
2. The mappings between the conceptual modules and the directories (dir_module_mapping.sql)
3. The mapping between conceptual modules (module_module_relation.sql)
4. A csv dump of the final architecture is in module_module_relation.csv

## The scripts folder contains the code to generate these mappings.
