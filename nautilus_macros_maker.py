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

print("What version are these macros? ")
versNo = str(input())
path = os.path.dirname(os.path.realpath(__file__))
mac = 'macros'

with tempfile.TemporaryDirectory() as macfolder:
    copy_tree(os.path.join(path,mac),macfolder)
    with zipfile.ZipFile(os.path.join(path, "Release Assets",'Nautilus_Macros_'+versNo+'.zip'),'a') as maczip:
        contents = fileList(macfolder)
        for item in contents:
            if 'desktop.ini' in item:
                    continue
            f = open(item,'r+')
            lines = f.readlines()
            f.seek(0)
            f.write('; Macro for the Nautilus 3D printer by Hydra Research \n')
            f.write('; Version: '+versNo+' \n \n')
            for line in lines:
                f.write(line)
            f.close()
            maczip.write(os.path.join(macfolder, item), os.path.relpath(item, macfolder))
    maczip.close()
