#!/bin/bash
while [ true ]
do

ping_res=$(timeout 2 ping google.com -c 1 2>&1)
echo $ping_res
if [ "$ping_res" == "ping: google.com: Temporary failure in name resolution" ] || [ "$ping_res" == '' ]; then
  echo 'no internet';
  pkill -xf '/bin/bash /root/run.sh'
  pkill openconnect
  /bin/bash /root/run.sh &
  sleep 30
fi

sleep 10

done
