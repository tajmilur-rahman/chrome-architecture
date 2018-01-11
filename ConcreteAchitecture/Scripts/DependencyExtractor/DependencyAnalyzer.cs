using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManagedAPI;

namespace Understand_API
{
    public class DependencyAnalyzer
    {
        public void AnalyzeSwitchesDependenciesByFiles(IEnumerable<Entity> entities)
        {
            using (var file = new StreamWriter("C:/understand_output"))
            {
                var switchCodeFiles = new List<Entity>();
                var switchReferenceIdList = new HashSet<int>();

                var codeFiles = entities.Where(IsCodeFile);

                var switchesHeaderFiles = GetSwitchHeaderFiles(codeFiles);

                var switchReferences = new List<Reference>();

                var processedCount = 0;

                // Get files that reference switch header files
                foreach (var switchesHeader in switchesHeaderFiles.OrderBy(s => Path.GetDirectoryName(s.NameLong)))
                {
                    processedCount += 1;
                    Console.Write("\rAnalyzed " + processedCount + " Entities     ");

                    file.WriteLine(switchesHeader.NameLong);

                    var switchHeaderFileReferences = 
                        switchesHeader.Refs("", "")
                        .Where(IsReferenceToCodeFile);

                    foreach (var reference in 
                        switchHeaderFileReferences
                        .Where(reference => !switchReferenceIdList.Contains(reference.ThisEntity.ID))
                        .OrderBy(reference => Path.GetDirectoryName(reference.ThisEntity.NameLong)))
                    {
                        switchReferenceIdList.Add(reference.ThisEntity.ID);
                        //switchReferences.Add(reference);
                        file.WriteLine("\t" + reference.ThisEntity.NameLong + ", " + Path.GetDirectoryName(reference.ThisEntity.NameLong));
                    }
                }

                Console.WriteLine();
            }
        }

        public void AnalyzeEntities(List<Entity> entities)
        {
            var covered = new HashSet<string>();

            using (var file = new StreamWriter("C:/entities"))
            {
                foreach (var ent in entities.Where(e => !covered.Contains(e.KindName)))
                {
                    covered.Add(ent.KindName);
                    file.WriteLine(ent.KindName + " Name: " + ent.NameShort + ", Line Declare Start: " + ent.LineDeclareStart + ", Line Define Start: " + ent.LineDefineStart + ", Line Define End: " + ent.LineDefineEnd);
                }
            }
        }

        public void AnalyzeReferences(List<Entity> entities, IEnumerable<Entity> switchesHeaderFiles)
        {
            var covered = new HashSet<string>();

            using (var file = new StreamWriter("C:/references"))
            {
                foreach (var ent in entities)
                {
                    var refs = ent.Refs("", "");

                    file.WriteLine(ent.NameShort + ", Unique: " + ent.NameUnique + ", Kind: " + ent.KindName);

                    foreach (var reference in refs)//.Where(reference => !covered.Contains(reference.KindName)))
                    {
                        covered.Add(reference.KindName);
                        file.WriteLine("\t" + reference.KindName + ", File: " + reference.File.NameShort + ", Line: " + reference.Line + ", This Entity:" + reference.ThisEntity.NameShort);
                    }
                }

                /*
                var refKinds = new HashSet<string>();
                
                foreach (var ent in entities)
                {
                    var refs =
                        ent.Refs("", "").Where(r => switchesHeaderFiles.Any(f => f.NameShort == r.ThisEntity.NameShort));

                    foreach (var reference in refs)
                    {
                        file.WriteLine(reference.KindName + ", " + reference.ThisEntity.NameLong + ", " + ent.NameLong);

                        if (!refKinds.Contains(reference.KindName))
                        {
                            refKinds.Add(reference.KindName);
                        }
                    }
                }
                
                foreach (var refKind in refKinds)
                {
                    file.WriteLine(refKind);
                }
                */
            }
        }

        public void AnalyzeSwitchesDependenciesByFlagReferences(List<Entity> entities, bool detailed)
        {
            // all switches cc files
            var switchesFiles = entities.Where(e => e.KindName == "C Code File" && e.NameShort.Contains("switches")).ToList();
            var globalObjectEntities = entities.Where(e => e.KindName == "C Object Global" && e.NameShort.StartsWith("k")).ToList();

            Console.WriteLine("Found " + switchesFiles.Count + " switches files");
            Console.WriteLine("Found " + globalObjectEntities.Count +  "Global Object Entities");

            var switchesRefs = new Dictionary<Entity, List<Reference>>();

            using (var file = new StreamWriter("C:/switches_references"))
            {
                foreach (var switchesFile in switchesFiles)
                {
                    // Get the actual switches in the file
                    var swfile = switchesFile;

                    switchesRefs.Add(switchesFile, new List<Reference>());

                    if (detailed)
                    {
                        file.WriteLine(swfile.NameLong + ", " + swfile.NameUnique);   
                    }

                    var switches = globalObjectEntities.Where(e => e.NameUnique.Contains(swfile.NameLong));
                    var covered = new HashSet<string>();

                    foreach (var @switch in switches)
                    {
                        if(detailed)
                        {
                            file.WriteLine("\t" + @switch.NameShort + ", Line: " + @switch.LineDefineStart);
                        }

                        var switchRefs = @switch.Refs("", "");
                        
                        foreach (var reference in switchRefs)
                        {
                            if (!covered.Contains(reference.File.NameLong))
                            {
                                if(!detailed)
                                {
                                    covered.Add(reference.File.NameLong);
                                    switchesRefs[switchesFile].Add(reference);
                                    //file.WriteLine("\t" + Path.GetDirectoryName(reference.File.NameLong) + "," + reference.File.NameShort);
                                }
                                else
                                {
                                    file.WriteLine("\t File: " + reference.File.NameLong + ", Referring Entity Name: " + reference.ThisEntity.NameLong + ", Line: " + reference.Line + ", Referred By Kind: " + reference.KindName);    
                                }
                            }
                        }
                    }
                }

                if (!detailed)
                {
                    foreach (var switchesRef in switchesRefs)
                    {
                        file.WriteLine(switchesRef.Key.NameLong);

                        foreach (var swr in switchesRefs[switchesRef.Key].OrderBy(r => r.File.NameLong))
                        {
                            file.WriteLine("\t" + Path.GetDirectoryName(swr.File.NameLong) + "\t" + swr.File.NameShort);
                        }
                    }
                }
            }
        }

        private IEnumerable<Entity> GetSwitchHeaderFiles(IEnumerable<Entity> codeFiles)
        {
            return 
                codeFiles
                .Where(e => e.NameShort.Contains("switch"))
                .Where(switchesFile => switchesFile.NameShort.EndsWith(".h"))
                .ToList();
        }

        private bool IsCodeFile(Entity entity)
        {
            return entity.KindName.Contains("C Code File") || entity.KindName.Contains("C Header File");
        }

        private bool IsNamespace(Entity entity)
        {
            return entity.KindName == "C Namespace";
        }

        private bool IsReferenceToCodeFile(Reference reference)
        {
            return IsCodeFile(reference.ThisEntity);
        }

        private bool IsGlobalObject(Reference reference)
        {
            return reference.KindName == "C Object Global";
        }
    }
}
