#!/usr/bin/python
# coding: utf-8

import sys
import urllib
import urllib2
import json

reload(sys)
sys.setdefaultencoding('utf-8')

url = "http://api.map.baidu.com/telematics/v3/weather?location=%E6%9D%AD%E5%B7%9E&output=json&ak=E577a29e33bc8df7619f6c364501fd09"
req = urllib2.Request(url)
#print req

res_data = urllib2.urlopen(req)
res = res_data.read()
#print res
jsonStr = json.loads(res)
todayDate = jsonStr['results'][0]["weather_data"][0]["date"]
todayWeather = jsonStr['results'][0]["weather_data"][0]["weather"]
todayTemp = jsonStr['results'][0]["weather_data"][0]["temperature"]

#tommoryDate = jsonStr['results'][0]["weather_data"][1]["date"]
#tommoryWeather = jsonStr['results'][0]["weather_data"][1]["weather"]
#tommoryTemp = jsonStr['results'][0]["weather_data"][1]["temperature"]

print "今天天气",todayWeather,"气温",todayTemp
