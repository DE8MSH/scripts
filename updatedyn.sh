#!/bin/sh

USERNAME="name"
PASSWORD="pw"
HOSTNAME="yourhost.dyndns.org"
#IP=`curl -s http://www.whatismyip.de | grep -o '\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}'`
IP=`curl http://automation.whatismyip.com/n09230945.asp`

ABUSE_LOCK_FILE="/tmp/dyndns.abuse"
LAST_IP_FILE="/tmp/lastip"
LAST_IP=`cat $LAST_IP_FILE`

#lockfile check, lockfile is only used if a abuse result appears
if [ -e "$ABUSE_LOCK_FILE" ]; then
     echo "Dyndns abuse lockfile exisits: $ABUSE_LOCK_FILE"  
     exit 1
fi
#end of lockfile check

if [ "$IP" != "$LAST_IP" ]; then
   echo "Current IP: $IP"
   RESULT=`curl -s "http://$USERNAME:$PASSWORD@members.dyndns.org/nic/update?hostname=$HOSTNAME&myip=$IP" | grep -o -E "good|nochg|abuse|badauth|notfqdn|nohost|abuse|dnserr"`
   echo "Dyndns.org says: $RESULT!"
else
   echo "IP is still the same: $LAST_IP"
fi

if [ "$RESULT" == "abuse" ]; then
   echo "Abuse lock!"
   echo "Abuse lock!" > "$ABUSE_LOCK_FILE"
fi

echo "$IP" > "$LAST_IP_FILE"
