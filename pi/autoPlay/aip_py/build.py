#!/usr/bin/python
# -*- coding: utf-8 -*-

from sys import argv
from aip import AipSpeech

APP_ID="xxx"
API_KEY="xxx"
SECRET_KEY="xxx"

# audioText: The text will be synthesis to audio
# audioPath: The audio will be saved as.
audioText = argv[1]
audioPath = argv[2]

aipSpeech = AipSpeech(APP_ID, API_KEY, SECRET_KEY)

result = aipSpeech.synthesis(audioText,'zh',1,{
    'vol': 5,       # 0-15,default 5 medium
    'pit': 6,
    'spd': 4,
    'per': 3
})

if not isinstance(result, dict):
    with open(audioPath, 'wb') as f:
        f.write(result)
