#!/bin/bash

TEMP=0
TEMP2=0
COUNT=0
DIR_PATH="~/.dwm/script/images/"
IMG_DIR=$(shuf -e $(ls $DIR_PATH) -n 1)
IMG=`date +%k`.jpg

feh --bg-fill --no-fehbg ~/.dwm/script/images/$IMG_DIR/$IMG


MESSAGES=$(shuf ~/.dwm/script/notebook.txt -n 1 | awk -F '；' '{ print " "$1 }' | awk '{ print $1" "$2" "$4$5 }')

while true;do

    # 内部计时器
    let TEMP++
    let TEMP2++

    # 半分钟刷新一次提示消息
    if [ "$TEMP" == "30" ];
    then
        TEMP=0
        MESSAGES=$(shuf ~/.dwm/script/notebook.txt -n 1 | awk -F '；' '{ print " "$1 }' | awk '{ print $1" "$2" "$4$5 }')
    fi

    # 十分钟刷新一次壁纸
    if [ "$TEMP2" == "600" ];
    then
        TEMP2=0
        IMG=`date +%k`.jpg
        
        feh --bg-fill --no-fehbg ~/.dwm/script/images/$IMG_DIR/$IMG
    fi

    # 电源状态
    BAT_CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$BAT_STATUS" == "Discharging" ];
    then
        BATTERY="󰁾$BAT_CHARGE%"  
    elif [ "$BAT_STATUS" == "Full" ]
    then
        BATTERY="󰁹" 
    elif [ -z "$BAT_CHARGE" ]
    then
        BATTERY="" 
    else
        BATTERY="󰢝 $BAT_CHARGE%" 
    fi

    # CPU 内存 音量 时间日期
    CPU=$( vmstat -S M | sed -n 3p | awk '{ print " " 100-$15 "%"}' )
    MEM_TOTAL=$( free -m | sed -n 2p |  awk '{ print $2 }' )
    MEM_USED=$( free -m | sed -n 2p |  awk '{ print $3 }' )
    MEM_SHARED=$( free -m | sed -n 2p |  awk '{ print $5 }' )
    MEMORY=`awk 'BEGIN{ printf "󰍛 %.1f%%", (('$MEM_USED'+'$MEM_SHARED')/'$MEM_TOTAL') * 100 }'`
    SOUND=$( amixer get Master|sed 's/\[/ /g'|sed 's/\]/ /g'|sed -n '6p'|awk '{ print " "$5 }' )
    DATE=$( date +" %F %R" )

    # MOCP音乐状态
    SONG=$( mocp -i | grep SongTitle | awk -F " " '{ printf(" 󰫔 "); for (i=2; i<NF;i++)printf("%s ", $i);printf("%s", $NF);print "" }' )

    # Display the status on dwm_bar
    xsetroot -name "$SONG $MESSAGES [$CPU $MEMORY] $BATTERY $SOUND $DATE "
    sleep 0.5s
done &
