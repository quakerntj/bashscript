#!/bin/bash
qa

if [ -d drivers/power ]; then
	cd  drivers/power
else
	if [ -d kernel/drivers/power ]; then
		cd kernel/drivers/power
	fi
fi

if [ $# -gt 1 ]; then
	echo $@
	$@
fi
