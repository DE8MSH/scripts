#!/bin/sh
pachube_api_key="key"
pachube_feedt="feedid"
        m=$(cat /proc/meminfo  | grep "MemFree:" | cut -d":" -f 2 | sed 's/ //g' | sed 's/kB//g')
        u=$(uptime | cut -d" " -f 5 | sed 's/,//g' | sed 's/:/./g')
	curl --request PUT --header "X-PachubeApiKey: "$pachube_api_key --data ""$m","$u"" "http://www.pachube.com/api/"$pachube_feedt".csv"
