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

#avconv -ss 30 -i 2018_0420_010013_001.MOV -i DejaVu_DaveRodger.mp3 -t 00:04:20 -filter_complex "[0:a]volume=1[a0];[1:a]volume=0.3[a1];[a0][a1]amix;[0:v]crop=1000:562:450:260" -s 852x480 -c:v libx264 -r 30 -b:v 1000k out_crop_dejavu.mp4
#avconv -i 2018_0804_065450_002.MOV -s 1280x720 -c:v libx264 -r 30 -b:v 2000k out7.mp4

#slow down
#avconv -i input.mkv -r 16 -filter:v "setpts=1.5*PTS" output.mkv
#

#ffmpeg -i 2018_0804_053648_003.MOV -framerate 60 -start_number 56 -loop 1 -i NTj86/PNG_%04d.png -filter_complex 'overlay=x=W-w-10:y=H-h-10:shortest=1' -t 00:00:30 -c:v libx264 -b:v 1000k out_overlay.mp4
#ffmpeg -y -i 0.mp4 -framerate 15 -start_number 52 -loop 1 -i NTj86ColorSmall/PNG_%04d.png -filter_complex 'overlay=x=W-w-10:y=H-h-10:shortest=1' -c:v libx264 -profile:v high -level 4.2 -b:v 2500k 0.logo.mp4
#https://youtu.be/vMbrHdr5v7I
#for youtube fast process
#ffmpeg -i video.mp4 -acodec copy -vcodec copy video.mkv


#ffmpeg -i 1.mp4 -c:v copy -bsf:v h264_mp4toannexb -c:a libfdk_aac -f mpegts 1.ts
#ffmpeg -i 2.mp4 -c:v copy -bsf:v h264_mp4toannexb -c:a libfdk_aac -f mpegts 2.ts
#ffmpeg -i "concat:1.ts|2.ts" -c copy -bsf:a aac_adtstoasc out.mp4
#$ ffmpeg -i "concat:1.ts|2.ts|3.ts|4.ts|5.ts" -framerate 15 -start_number 52 -loop 1 -i NTj86ColorSmall/PNG_%04d.png -filter_complex 'overlay=x=W-w-10:y=H-h-10:shortest=1' -c:v libx264  -profile:v high -level 4.2 -s 960x540 -b:v 1800k -c:a aac_adtstoasc out.mkv

# Black the GPS time
# overlay logo
# scale 960x540
# audio aac


#ffmpeg -y \
# -ss 00:02:00 -i zzz.MOV \
# -framerate 15 -start_number 52 -loop 1 -i NTj86ColorSmall/PNG_%04d.png \
# -filter_complex '[0:v]scale=1920/2:1080/2[mv]; [mv]drawbox=0:500:480:30:black:t=fill[mv2]; [mv2][1:v]overlay=x=W-w-10:y=H-h-10:shortest=1' \
# -t 00:00:20 \
# -c:a aac -b:a 128k -c:v libx264 -profile:v high -level 4.2 -r 30 -b:v 2500k zzz.mp4


#ffmpeg -y \
# -ss 00:01:42 -i 180820/2018_0820_124614_004.MOV \
# -framerate 15 -start_number 52 -loop 1 -i NTj86ColorSmall/PNG_%04d.png \
# -filter_complex '
#    [0:a]
#    equalizer=f=100:t=h:width=50:g=2,
#    equalizer=f=300:t=h:width=150:g=2,
#    equalizer=f=34:t=h:width=34:g=-8
#    [ae];
#    [0:v]scale=1920/2:1080/2[mv];
#    [mv]drawbox=0:500:480:30:black@0.8:t=fill[mv1];
#    [mv1]drawbox=0:500:190:30:black:t=fill[mv2];
#    [mv2]drawbox=260:500:220:30:black:t=fill[mv3];
#    [mv3][1:v]overlay=x=W-w-10:y=H-h-10:shortest=1[out]' \
# -map "[out]" -map "[ae]" \
# -t 00:00:08 \
# -c:a aac -b:a 128k -c:v libx264 -profile:v high -level 4.2 -r 30 -b:v 2500k zzz.mp4
