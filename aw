#!/bin/bash
ga
cd packages/apps/HtcAddProgramWidget/src/com/htc/AddProgramWidget/
if [ $# -gt 1 ]; then
	echo $@
	$@
fi
