#! /bin/python
import os, sys
import csv
import psycopg2
import sys
from os import listdir
from os.path import isfile, join
#import util

def dirTreeDistance(path1, path2):
	#dir1 = os.path.dirname(path1)
	#dir2 = os.path.dirname(path2)
        parts1 = os.path.normpath(path1).split(os.path.sep)
        parts2 = os.path.normpath(path2).split(os.path.sep)
        if parts1 == ['', '']:
            parts1 = ['']
        if parts2 == ['', '']:
            parts2 = ['']
        if parts1 == parts2:
            return 0
        #print min(len(parts1), len(parts2))
        i = 0
        while i < min(len(parts1), len(parts2)):
            if parts1[i] != parts2[i]:
                break
            i += 1
        dist = len(parts1) - i + len(parts2) - i
        return dist - 1

#print dirTreeDistance("/foo/bar.c", "/foo/bar.c")
#print dirTreeDistance("/foo/bar.c", "/foo/tree.c")
#print dirTreeDistance("/foo/bar.c", "/happy.c")
#print dirTreeDistance("/foo/bar.c", "/green/joe.c")
#print dirTreeDistance("/foo/bar.c", "/foo/green/joe.c")
#print dirTreeDistance("/foo/bar.c", "/foot/head/joe.c")
#print dirTreeDistance("/foo/bavar.c", "/foot/head/green/joe.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/foo/bar.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/foo/tree.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/happy.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/green/joe.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/foo/green/joe.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/foot/head/joe.c")
#print dirTreeDistance("/a/foo/bar.c", "/a/foot/head/green/joe.c")

files = [ f for f in listdir('feature-files34') if isfile(join('feature-files34', f)) ]

for fname in files:
    paths = []
    paths2 = []
    with open('feature-files34/'+fname, 'rb') as f:
        for line in f:
            paths.append(line.rstrip('\r\n'))
            paths2.append(line.rstrip('\r\n'))
    
        count = 0
        con = psycopg2.connect(database='feature_toggles_new', user='rupak')
        cur = con.cursor()
        for path in paths:
            count2 = 0
            for path2 in paths2:
                path1 = paths[count]
                path2 = paths2[count2]
                dist = dirTreeDistance(path1, path2)
                print "insert into directory_dist(switch_set, path1, path2, dist, release) values ('"+fname.rstrip('.txt')+"',chromium/"+path1+"','chromium/"+path2+"',"+str(dist)+", 34.0)"
                cur.execute("insert into directory_dist(switch_set, path1, path2, dist, release) values ('"+fname.rstrip('.txt')+"','chromium/"+path1+"','chromium/"+path2+"',"+str(dist)+", 34.0)")
                count2 = count2+1
            count = count+1
        con.commit()
