#!/bin/bash

FILE="/home/"$USER""
#FILEB="/var/log/host_info/monitor.log"
function usage()
{
	echo "use -f to specify the file. Your path is 'home/user/[yourfile]'"
	echo "use -s to display the results to stdout"
}

function commands(){
        while true
        do
        #date
        

        #ps -eo pid,ppid,cmd,%mem --sort=-%mem |head -n 10
	#c1=$(ps -eo %mem --sort=-%mem | awk 'NR==2 {print "max mem usage:"$1"%"}')
	c1=$(free -g | grep Mem | awk '{print "free mem:" $4}')
        
        #df -h 
	#c2=$(df -h --output=size --total | awk 'END {print "total space:" $4}')
       	c2=$(df -h / | awk 'END {print "available space:" $4}') 
        #uptime
	#c3=$(uptime |awk '{print "15m load avarage:"$12}')
	#c3=$(uptime | awk -F'load average:' '{print "1m 5m 15m load avarage:"$2}')
	c3=$(cat /proc/loadavg | awk '{print "15m load avg:"$3}')
	#c4=$(ps -aux |grep "defunct" |wc -l)
	c4=$(ps -aux|grep -v grep|grep "defunct"|wc -l|awk '{print "zombieS:" $1}')

	#c5=$(vnstat | grep today | awk '{print "rx:" $2$3 " tx:" $5$6}')
	#c5=$(netstat -i | grep wlp2s0 | awk '{print "wifi RX packets until now:"$3 ",wifi TX packets until now:" $7}')
	c5=$(netstat -i | sed 1,2d | awk '{SUM+=$3;SUM1+=$7}END{print "RX packets until now:"SUM",TX packets until now:"SUM1}')
	echo $(date +"%b %d %H:%M:%S"): $c1,$c2,$c3,$c4,$c5

        sleep 10s
        done
}

if ! [ -x "$(command -v netstat)" ]; then
   echo 'Error: netnstat is not installed: sudo apt install vnstat' >&2
   exit 1
fi


while getopts f:s param ; do
case $param in
	f)
        echo "press ctrl c to terminate the execution"

	 #commands 2>&1 1> $FILE/$2
	 commands &> $FILE/$2

	;;
	s)
	DIR="/var/log/host_info/"
	if [ ! -d "$DIR" ]; then
  		# Take action if not $DIR exists. #
		mkdir /var/log/host_info

  		echo "created /var/log/host_info directory"
	fi
	 commands &>> "/var/log/host_info/monitor.log"
	;;
	*)
	echo "invalid argument"
	;;
esac
done

shift $((OPTIND-1))
usage
