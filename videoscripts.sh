adb pull "/storage/sdcard0/DCIM/RaceChrono/1.MOV" .
adb pull "/storage/sdcard0/DCIM/RaceChrono/2.MOV" .
adb pull "/storage/sdcard0/DCIM/RaceChrono/3.MOV" .
adb pull "/storage/sdcard0/DCIM/RaceChrono/4.MOV" .
avconv -y -i 1.MOV -vf "movie=/home/quaker/document/SignWaterMark.PNG [watermark];  [in][watermark] overlay=W-w-50:H-h-50 [out]" -s 1280x720 -b 5000k 1.mp4
avconv -y -i 2.MOV -vf "movie=/home/quaker/document/SignWaterMark.PNG [watermark];  [in][watermark] overlay=W-w-50:H-h-50 [out]" -s 1280x720 -b 5000k 2.mp4
avconv -y -i 3.MOV -vf "movie=/home/quaker/document/SignWaterMark.PNG [watermark];  [in][watermark] overlay=W-w-50:H-h-50 [out]" -s 1280x720 -b 5000k 3.mp4
avconv -y -i 4.MOV -vf "movie=/home/quaker/document/SignWaterMark.PNG [watermark];  [in][watermark] overlay=W-w-50:H-h-50 [out]" -s 1280x720 -b 5000k 4.mp4
adb push 1.mp4 /storage/sdcard0/DCIM/RaceChrono/
adb push 2.mp4 /storage/sdcard0/DCIM/RaceChrono/
adb push 3.mp4 /storage/sdcard0/DCIM/RaceChrono/
adb push 4.mp4 /storage/sdcard0/DCIM/RaceChrono/
echo "After overlay guages, "
echo "do \"avconv -i up.mp4 -c:v libx264 -c:a copy -b 4500k -bf 2 -s 1280x720 up.mp4\""
echo "do \"avconv -i down.mp4 -c:v libx264 -c:a copy -b 4500k -bf 2 -s 1280x720 down.mp4\""

# overlay front camera at top left corner
#avconv -i 20150317_up.mp4 -vf 'movie=face.mp4 [f]; [in][f] overlay=0:0 [out]' out.mp4
#avconv -i 20150317_up.mp4 -vf 'movie=face.mp4,format=rgba,lutrgb=a=30 [face]; [in][face] overlay=0:0 [out]' out.mp4

# Split Screen / with drawbox
#avconv -i vid.mp4 -vf '[in] drawbox=239:0:480:270:black@0.75 [ii]; movie=vidstab.mp4 [f]; [f] crop=240:270:240:0 [c]; [ii][c] overlay=240:0 [out]' -c:v libx264 -b 500k out.mp4
#avconv -i vid.mp4 -vf 'movie=vidstab.mp4 [f]; [f] crop=240:270:240:0 [c]; [in][c] overlay=240:0 [out]' -c:v libx264 -b 500k out.mp4

# overlay front camera at top with black border
#avconv -i vid.mp4 -vf '[in] drawbox=190:8:100:52:black@1 [ii]; movie=vidstab.mp4 [f]; [f] scale=480/5:240/5 [c]; [ii][c] overlay=480/2-480/5/2:10 [out]' -c:v libx264 -b 500k out.mp4

#錄影時使用milisecond定位, 先用avprobe取得時間差, 結束錄影後, 需要將video rate調整成一樣的 (-r 30?) 時序才不會錯亂

#7.93 - 11:09:00.028
#相差0.501
#2.37 - 11:09:00.529
#7.93+0.501-2.37 = 6.061
#avconv -i vid1.large.mp4 -ss 6.061 -c:v libx264 -s 720x480 -r 30 -b 4500k vid1.mp4
#avconv -i vid2.large.mp4 -c:v libx264 -s 90x60 -r 30 -b 4500k vid2.mp4
#avconv -i vid1.mp4 -vf 'movie=vid2.mp4 [f]; [in][f] overlay= [out]' -c:v libx264 -b 500k out.mp4

