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

curl "api.openweathermap.org/data/2.5/forecast?q=$LOC&appid=$APIKEY" -o pogoda.json
TIME=`cat pogoda.json | jq ".list[5].dt_txt"`
TEMP=`cat pogoda.json | jq ".list[5].main.temp"`
### free api lets us get forecasted values for the next 3,6,9,12,15 ... hours up to 5 days. 
### In above lines you can change list[5] to list [0] to get forecast for 3hrs. You mauy change it to list[7] to get forecast for 24hrs from now.

TEMPINT=${TEMP%.*}
(( TEMPC="$TEMPINT-273" ))
echo $TIME
echo $TEMPC
curl --silent "$DOMO/json.htm?type=command&param=udevice&idx=$IDX&nvalue=0&svalue=$TEMPC"
rm -f pogoda.json

