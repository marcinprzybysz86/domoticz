#!/bin/bash
STATE=`curl -s http://192.168.1.197/api/powerstate | jq '.instandby'`
DOMOSTATE=`curl -s 
http://192.168.1.200:8080/json.htm?type=devices\&rid=55 | jq 
'.result[0].Status' | tr -d '"'`
DOMO=192.168.1.200:8080
IDX=55   

if [ "$STATE" == "false" ]; then
        if [ "$DOMOSTATE" == "Off" ]; then
        wget -O - 
"$DOMO/json.htm?type=command&param=switchlight&idx=$IDX&switchcmd=On" > 
/dev/null 2>&1
        fi
fi
if [ "$STATE" == "true" ]; then
        if [ "$DOMOSTATE" == "On" ]; then
        wget -O - 
"$DOMO/json.htm?type=command&param=switchlight&idx=$IDX&switchcmd=Off" > 
/dev/null 2>&1
        fi
fi
#echo $STATE
#echo $DOMOSTATE

