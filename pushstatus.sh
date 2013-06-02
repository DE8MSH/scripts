#!/bin/sh
pachube_api_key="YauKtjXhrGw7XMzvVfL54f9ZlIeSAKxLaDFNN0hYV0JaQT0g"
pachube_feedt="84554"
        m=$(cat /proc/meminfo  | grep "MemFree:" | cut -d":" -f 2 | sed 's/ //g' | sed 's/kB//g')
        u=$(uptime | cut -d" " -f 5 | sed 's/,//g' | sed 's/:/./g')
	curl --request PUT --header "X-PachubeApiKey: "$pachube_api_key --data ""$m","$u"" "http://www.pachube.com/api/"$pachube_feedt".csv"
