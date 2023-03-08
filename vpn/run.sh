#!/bin/bash
SERVER_IP=54.224.57.48
while [ true ]
do
ip route add 23.113.226.251/32 via 45.159.115.254
ip route add $SERVER_IP/32 via 45.159.115.254
ip route del default via 45.159.115.254

for range in $(jq .[] /root/iran_ip_ranges.json | sed 's/"//g' | xargs); do ip route add $range via 45.159.115.254; done;
sysctl -w net.ipv4.ip_forward=1
sudo iptables -A FORWARD -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE


  sleep 2
  cat input | /usr/local/sbin/openconnect $SERVER_IP:8443 -u admin -p 09120912
  pkill openconnect
  sleep 3

done
