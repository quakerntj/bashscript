#!/bin/bash
OUT_PATH=$TOP/out/target/product/endeavoru
RECOVERY_IMG=$OUT_PATH/recovery.img
HBOOT_IMG=$OUT_PATH/hboot.img
NVFF=$TOP/out/host/linux-x86/bin/nvflash
MKBOOTFS=$TOP/out/host/linux-x86/bin/mkbootfs
MKBOOTIMG=$TOP/out/host/linux-x86/bin/mkbootimg
MINIGZIP=$TOP/out/host/linux-x86/bin/minigzip

if [ ! -f $OUT_PATH/recovery/root/sbin/htcbatt ]; then
	echo "Not found htcbatt in recovery image."
	sleep 2
	cp -v $OUT_PATH/symbols/system/bin/htcbatt $OUT_PATH/recovery/root/sbin
	cp -v $OUT_PATH/symbols/system/bin/choice_fn $OUT_PATH/recovery/root/sbin
	cp -v $OUT_PATH/symbols/system/bin/detect_key $OUT_PATH/recovery/root/sbin
	cp -v $OUT_PATH/symbols/system/bin/offmode_charging $OUT_PATH/recovery/root/sbin
	sleep 2
	echo "make new Recovery image"
	$MKBOOTFS $OUT_PATH/recovery/root | $MINIGZIP > $OUT_PATH/ramdisk-recovery.img
	$MKBOOTIMG --kernel $OUT_PATH/kernel --ramdisk $OUT_PATH/ramdisk-recovery.img --output $OUT_PATH/recovery.img
fi

echo
echo "-----------------------------------------------------------"
echo "Loop to find nvflash."
echo "Please hold volumn-up and plug usb until \"Update Success\""
echo "At least, need 5min"
echo "-----------------------------------------------------------"

test 0 -eq 1
while [ $? -ne 0 ];
do
	sleep 4
	echo
	$NVFF --download 12 $RECOVERY_IMG --bl $HBOOT_IMG --go
done
echo "Update Success"
