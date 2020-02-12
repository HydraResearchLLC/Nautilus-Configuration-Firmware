#Nautilus configuration maker by Hydra Research, LLC

import os
import shutil
import zipfile
import tempfile
from distutils.dir_util import copy_tree
from distutils.file_util import copy_file
import json
import requests
import urllib

def fileList(fileName):
    files = list()
    for (dirpath, dirnames, filenames) in os.walk(fileName):
        files += [os.path.join(dirpath, file) for file in filenames]
    return files


DWCZipUrl = None
path = os.path.dirname(os.path.realpath(__file__))
Duet2FirmwareRelUrl = json.loads(requests.get('https://api.github.com/repos/dc42/reprapfirmware/releases').text)
DuetWifiServerUrl = json.loads(requests.get('https://api.github.com/repos/dc42/reprapfirmware/releases/latest').text)['assets'][4]['browser_download_url']
DuetFirmVers = json.loads(requests.get('https://api.github.com/repos/dc42/reprapfirmware/releases/latest').text)['tag_name']
DWCRelUrl = json.loads(requests.get('https://api.github.com/repos/chrishamm/duetwebcontrol/releases').text)

print("Building Nautilus Configuration for the Duet2")
print("What version is this config?")
versNo = str(input())
print("Downloading Wifi Server...")

urllib.request.urlretrieve(DuetWifiServerUrl,os.path.join(path,'Downloaded Assets',os.path.basename(DuetWifiServerUrl)))

print('Which DWC version do you want? Type version number in form x.x.x then hit enter')
DWCentry = str(input())
print('Downloading DWC...')

for i in range(10):
    newVersionfull = json.dumps(DWCRelUrl[i]['tag_name'])
    if DWCentry in newVersionfull:
        DWCZipUrl = DWCRelUrl[i]['assets'][1]['browser_download_url']
        print('Got it, we\'re downloading from '+DWCZipUrl+'...')
        urllib.request.urlretrieve(DWCZipUrl, os.path.join(path,'Downloaded Assets', os.path.basename(DWCZipUrl)))
if DWCZipUrl == None:
    print('Unable to find DWC version '+DWCentry)

print('Which Duet firmware version do you want? Type version number in form x.x then hit enter')
DuetFirmwareEntry = str(input())
print('Downloading Duet Firmware')

for i in range(10):
    newVersionfull = json.dumps(Duet2FirmwareRelUrl[i]['tag_name'])
    if DuetFirmwareEntry in newVersionfull:
        #John: download the correct firmware bin Duet2Combined. Did this by changing [1] to [0] as Duet2Combined is the first item in the assets list
        Duet2FirmwareUrl = Duet2FirmwareRelUrl[i]['assets'][0]['browser_download_url']
        print('Got it, we\'re downloading from '+Duet2FirmwareUrl+'...')
        urllib.request.urlretrieve(Duet2FirmwareUrl, os.path.join(path,'Downloaded Assets', os.path.basename(Duet2FirmwareUrl)))
        break
if Duet2FirmwareUrl == None:
    print('Unable to find Duet Firmware version '+DuetFirmwareEntry)

dwc = os.path.join('Downloaded Assets',os.path.basename(DWCZipUrl))
duetfirm = os.path.join(path,'Downloaded Assets',os.path.basename(Duet2FirmwareUrl))
duetwifi = os.path.join(path,'Downloaded Assets',os.path.basename(DuetWifiServerUrl))
sys = 'sys'

with tempfile.TemporaryDirectory() as configfolder:
    #copy /sys folder to nautilus configuration
    copy_tree(os.path.join(path,sys),configfolder)
    copy_file(duetfirm,configfolder)
    copy_file(duetwifi,configfolder)
    with zipfile.ZipFile(os.path.join(path, dwc)) as dwczip:
    #extract downloaded DWC zip to nautilus configuration
        dwczip.extractall(configfolder)
    with zipfile.ZipFile(os.path.join(path,'Release Assets','Nautilus_Configuration_'+versNo+'.zip'),'w') as configzip:
        contents = fileList(configfolder)
        for item in contents:
            if 'Icon' in item:
                continue
            if '.ini' in item:
                continue
            if item.endswith('.g') or item.endswith('.bak'):
                f = open(item,'r+')
                lines = f.readlines()
                f.seek(0)
                f.write('; Configuration for the Nautilus 3D printer by Hydra Research \n')
                f.write('; Version: '+versNo+' (for Duet2 Firmware version '+DuetFirmVers+') \n')#dynamically insert version no
                for line in lines:
                    f.write(line)
                f.close()
            configzip.write(os.path.join(configfolder, item), os.path.relpath(item, configfolder))
    configzip.close()
