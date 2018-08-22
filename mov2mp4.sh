#MOV process

echo "MOV2MP4"
echo

if [ -f "$1" -o -d "$1" ]; then

list=`ls -1 "$1"`

echo $list 
echo

if [ -d "$1" ]; then
    cd $1
fi

mkdir MP4

for mov in $list
do
    name=`basename -z "$mov" .MOV`

    if [ -f "$name.MOV" ]; then
        ffmpeg -y \
 -i $name.MOV \
 -framerate 15 -start_number 52 -loop 1 -i NTj86ColorSmall/PNG_%04d.png \
 -filter_complex '
    [0:a]
        equalizer=f=100:t=h:width=50:g=3,
        equalizer=f=300:t=h:width=150:g=2,
        equalizer=f=34:t=h:width=34:g=-8
    [ae];
    [0:v]
        scale=1920/2:1080/2,
        drawbox=0:500:480:30:black@0.8:t=fill,
        drawbox=0:500:190:30:black:t=fill,
        drawbox=260:500:220:30:black:t=fill
    [mv];
    [mv][1:v]overlay=x=W-w-10:y=H-h-10:shortest=1[out]' \
 -map "[out]" -map "[ae]" \
 -c:a aac -b:a 128k -c:v libx264 -profile:v high -level 4.2 -r 30 -b:v 2500k MP4/$name.mp4

        echo
        echo
    fi
done

else
    echo "Need input file which has ext .MOV or a directory contains *.MOV"
fi # -f $1
