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

path = os.path.dirname(os.path.realpath(__file__))
mac = 'macros'

with tempfile.TemporaryDirectory() as macfolder:
    copy_tree(os.path.join(path,mac),macfolder)
    with zipfile.ZipFile(os.path.join(path,'Nautilus_Macros_1.0.zip'),'w') as maczip:
        contents = fileList(macfolder)
        for item in contents:
            if os.path.basename(item)!='desktop.ini':
                #print(item)
                maczip.write(os.path.join(macfolder, item), os.path.relpath(item, macfolder))
    maczip.close()
