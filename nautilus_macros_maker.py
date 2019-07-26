#Nautilus macros maker by Hydra Research, LLC

import os
import shutil
import zipfile
import tempfile
from distutils.dir_util import copy_tree

def fileList(fileName):
    files = list()
    for (dirpath, dirnames, filenames) in os.walk(fileName):
        files += [os.path.join(dirpath, file) for file in filenames]
    return files

print("What version is this config? ")
versNo = str(input())
path = os.path.dirname(os.path.realpath(__file__))
mac = 'macros'

with tempfile.TemporaryDirectory() as macfolder:
    copy_tree(os.path.join(path,mac),macfolder)
    with zipfile.ZipFile(os.path.join(path,'Nautilus_Macros_'+versNo+'.zip'),'w') as maczip:
        contents = fileList(macfolder)
        for item in contents:
            if 'Icon' in item:
                contents.remove(item)
                continue
            if item!=os.path.join(macfolder, 'desktop.ini'):
                f = open(item,'r+')
                lines = f.readlines()
                f.seek(0)
                f.write('; Configuration for the Nautilus 3D printer by Hydra Research \n')
                f.write('; Version: '+versNo+' \n')
                for line in lines:
                    f.write(line)
                f.close()
                #print(item)
                maczip.write(os.path.join(macfolder, item), os.path.relpath(item, macfolder))
    maczip.close()
