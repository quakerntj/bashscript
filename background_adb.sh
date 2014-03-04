#!/system/bin/sh

while [ 1 ];
do
	/system/bin/getevent -di 2>&1 >> /data/event.log
	sleep $@
done
   

