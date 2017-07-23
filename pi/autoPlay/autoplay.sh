#!/bin/bash
## 利用百度语音合成自动播放当前时间
player="omxplayer"
audioPath="/home/pi/autoPlay/audio"

URL_PRE="http://tts.baidu.com/text2audio?lan=zh&ie=UTF-8&spd=4&text="

init(){
    if [ -d ${audioPath} ];then
        rm -rf ${audioPath}/
    fi
}

doCmd(){
    url=$1
    saveFile=$2
    dirname=`dirname ${saveFile}`
    if [ ! -d ${dirname} ];then
        mkdir -p ${dirname}
    fi
    wget -O ${saveFile} ${url}
    if [ $? -ne 0 ];then
        echo "获取音频失败"
        exit
    fi
}

playAudio(){
    file=$1
    ${player} ${file}
}

#开始运行
init

#播放当前时间
time=`date +%R`
text="'现在时间${time}'"
doCmd ${URL_PRE}${text} ${audioPath}/time.mp3
playAudio ${audioPath}/time.mp3

#播放天气
weatherText=`python getWeather.py`
weatherText=`echo ${weatherText} | sed -e s/\ /%20%20/g -e s/\ /%20%20/g -e s/~/到/g`
if [ $? -ne 0 ];then
    echo "获取天气失败"
    exit
fi
doCmd ${URL_PRE}'"'${weatherText}'"' ${audioPath}/weather.mp3
playAudio ${audioPath}/weather.mp3
