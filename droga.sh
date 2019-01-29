
#!/bin/bash
##### Marcin Przybysz 2019 #########
##### use + instead of space in FROM and TO address! ######

KEY=TWOJ_KLUCZ_API
FROM=Warszawa+Krucza+64
TO=Warszawa+Chelmzynska+1
CZAS=`curl -s "https://maps.googleapis.com/maps/api/directions/json?origin=$FROM&destination=$TO&transit_mode=driving&departure_time=now&key=$KEY" | jq '.routes[0].legs[0].duration_in_traffic.value'`
WYNIK=$(($CZAS/60))

DOMO=192.168.1.200:8080
IDX=56

wget -O - "$DOMO/json.htm?type=command&param=udevice&idx=$IDX&nvalue=0&svalue=$WYNIK" > /dev/null 2>&1
