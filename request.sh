for i in {1..50}
do
    time=`node -e "a = new Date; console.log(a.getTime());"`
    get_response=`curl -b cookies.txt -s "http://hd.global.mi.com/in/sec/startgame?from=mb&stage=$i&_=$time&jsonpcallback=jsonpCallback" -H 'Host: hd.global.mi.com' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://mobile.mi.com/in/events/2ndanniversary/playgame/game/' -H 'Connection: keep-alive'`

    path=`echo "$get_response" | sed "s|.*[^{]\({.*[^\}]}\)|\1 |g" | cut -d "\"" -f 4 | grep -o . | sort | tr -d "\n"`
    graph_id=`echo "$get_response" | sed "s|.*[^{]\({.*[^\}]}\)|\1 |g" | cut -d "\"" -f 7 | grep -o  "[0-9]\+"`
    curl  -b cookies.txt "http://hd.global.mi.com/in/sec/endgame?from=mb&stage=$i&use_time=0&graph_id=$graph_id&path=$path&_=$time&jsonpcallback=jsonpCallback" -H 'Host: hd.global.mi.com' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: http://mobile.mi.com/in/events/2ndanniversary/playgame/game/'
done
