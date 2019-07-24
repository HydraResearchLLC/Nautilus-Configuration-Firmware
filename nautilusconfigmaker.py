#Nautilus configuration maker by Hydra Research, LLC

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
dwc = 'DuetWebControl-Duet2.zip'
duet = 'Duet2Firmware-2.03.zip'
sys = 'sys'

with tempfile.TemporaryDirectory() as configfolder:
    copy_tree(os.path.join(path,sys),configfolder)
    with zipfile.ZipFile(os.path.join(path, dwc)) as dwczip:
        dwczip.extractall(configfolder)
    with zipfile.ZipFile(os.path.join(path, duet)) as duetzip:
        duetzip.extractall(configfolder)
    with zipfile.ZipFile(os.path.join(path,'Nautilus_Configuration_1.0.zip'),'w') as configzip:
        contents = fileList(configfolder)
        for item in contents:
            if item!=os.path.join(configfolder, 'desktop.ini'):
                configzip.write(os.path.join(configfolder, item), os.path.relpath(item, configfolder))
    configzip.close()
