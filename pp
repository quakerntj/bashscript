#!/bin/bash
if [ -f /tmp/pushpath.tmp ]; then
	A=0
	for Q in /tmp/pushpath.tmp
	do
		echo DEBUG: Q
		if [ $A -eq 0 ]; then
			QUEUE_PATH1=$Q
			A=1;
		else
			QUEUE_PATH2=$Q
		fi
	done
fi
echo Curr Path1: $QUEUE_PATH1 Path2: $QUEUE_PATH2

if [ "$1" == "e" ]; then
	echo $2 $QUEUE_PATH1 $QUEUE_PATH2
	$2 $QUEUE_PATH1 $QUEUE_PATH2
else

	if [ "$1" == "2" ]; then
		QUEUE_PATH2=$PWD
	else
		QUEUE_PATH1=$PWD
	fi
	echo $QUEUE_PATH1 > pushpath.tmp
	echo $QUEUE_PATH2 >> pushpath.tmp
	echo Push $PWD
	echo Path1: $QUEUE_PATH1 Path2: $QUEUE_PATH2
fi
