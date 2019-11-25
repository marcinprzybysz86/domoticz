###############################
# Marcin Przybysz
###############################
# script to get temperature for the next 18 hrs and 
#send it to domoticz dummy temperature switch. 
# Personally I've added it to crontab everyday at 12 am.

#!/bin/bash
APIKEY=<openweathermap_FreeApiKey>
LOC="warszawa,pl"
IDX=<domoticz_dummy_temp_idx>
DOMO="http://127.0.0.1:8080"

RESULT=`curl "api.openweathermap.org/data/2.5/forecast?q=$LOC&appid=$APIKEY"`
TIME=`echo $RESULT | jq ".list[5].dt_txt"`
TEMP=`echo $RESULT | jq ".list[5].main.temp"`
TEMPINT=${TEMP%.*}
(( TEMPC="$TEMPINT-273" ))
echo $TIME
echo $TEMPC
curl --silent "$DOMO/json.htm?type=command&param=udevice&idx=$IDX&nvalue=0&svalue=$TEMPC"


