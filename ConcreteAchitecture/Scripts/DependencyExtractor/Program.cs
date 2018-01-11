using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using ManagedAPI;

namespace Understand_API
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            string dbPath = args.Length > 0 ? args[0] : "C:/Users/aliosha/Documents/Understand/chromium22.udb";

            var isOpen = Database.Open(dbPath);

            Console.WriteLine(isOpen ? "Database loaded successfully" : "Could not Load database");

            if (!isOpen)
            {
                return;
            }

            //var functions = Database.GetAllFunctions();
            //var files = Database.GetFileEntities();
            var entities = Database.GetAllEntities();

            Console.WriteLine("Finished loading entities");
            Console.WriteLine(entities.Length + " Entities found");

            //Console.WriteLine(functions.Length + " functions found");
            //Console.WriteLine(files.Length + " files found");

            var dependencyAnalyzer = new DependencyAnalyzer();

            Console.WriteLine("Analyzing dependencies...");

            //dependencyAnalyzer.AnalyzeSwitchesDependenciesByFiles(entities);
            //dependencyAnalyzer.AnalyzeReferences(entities.ToList(), null);

            //dependencyAnalyzer.AnalyzeEntities(entities.ToList());

            dependencyAnalyzer.AnalyzeSwitchesDependenciesByFlagReferences(entities.ToList(), true);
            Console.WriteLine("Done");
            Console.ReadLine();
        }
    }
}
