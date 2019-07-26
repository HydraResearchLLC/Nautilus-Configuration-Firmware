#Nautilus configuration maker by Hydra Research, LLC

import os
import shutil
import zipfile
import tempfile
from distutils.dir_util import copy_tree
import json
import requests
import urllib

def fileList(fileName):
    files = list()
    for (dirpath, dirnames, filenames) in os.walk(fileName):
        files += [os.path.join(dirpath, file) for file in filenames]
    return files
print("What version is this config? ")
versNo = str(input())
path = os.path.dirname(os.path.realpath(__file__))
zip_file_url = json.loads(requests.get('https://api.github.com/repos/dc42/reprapfirmware/releases/latest').text)['assets'][1]['browser_download_url']
urllib.request.urlretrieve(zip_file_url,os.path.join(path,os.path.basename(zip_file_url)))

dwc = os.path.basename(zip_file_url)
duet = 'Duet2Firmware-2.03.zip'
sys = 'sys'

with tempfile.TemporaryDirectory() as configfolder:
    copy_tree(os.path.join(path,sys),configfolder)
    with zipfile.ZipFile(os.path.join(path, dwc)) as dwczip:
        dwczip.extractall(configfolder)
    with zipfile.ZipFile(os.path.join(path, duet)) as duetzip:
        duetzip.extractall(configfolder)
    with zipfile.ZipFile(os.path.join(path,'Nautilus_Test_Configuration_'+versNo+'.zip'),'w') as configzip:
        contents = fileList(configfolder)
        for item in contents:
            if 'Icon' in item:
                contents.remove(item)
                continue
            print(os.path.basename(item))
            if item!=os.path.join(configfolder, 'desktop.ini'):
                if item.endswith('.g') or item.endswith('.bak'):
                    f = open(item,'r+')
                    lines = f.readlines()
                    f.seek(0)
                    f.write('; Configuration for the Nautilus 3D printer by Hydra Research \n')
                    f.write('; Version: '+versNo+' \n')
                    for line in lines:
                        f.write(line)
                    f.close()
                configzip.write(os.path.join(configfolder, item), os.path.relpath(item, configfolder))
    configzip.close()
