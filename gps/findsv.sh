
function findsv() {
    grep "Fix: true SV: $1 "  HTC_GPS_NMEA_19.06.06.txt | cut -d " " -f 8,10 > "SV$1"
}

findsv 1
findsv 2
findsv 3
findsv 4
findsv 5
findsv 6
findsv 7
findsv 8
findsv 9
findsv 10
findsv 11
findsv 12
findsv 13
findsv 14
findsv 15
findsv 16
findsv 17
findsv 18
findsv 19
findsv 20
findsv 21
findsv 22
findsv 23
findsv 24
findsv 25
findsv 26
findsv 27
findsv 28
findsv 29
findsv 30
findsv 31
findsv 32
findsv 33
findsv 34
findsv 35
findsv 36
findsv 37
findsv 38
findsv 39 

function plotit() {
    echo 'set output "'$1'.png"'
    echo 'plot "SV'$1'" using 2:(90-$1) notitle'
}

plotit 1 >> ttt 
plotit 2 >> ttt
plotit 3 >> ttt
plotit 4 >> ttt
plotit 5 >> ttt
plotit 6 >> ttt 
plotit 7 >> ttt 
plotit 8 >> ttt 
plotit 9 >> ttt 
plotit 10 >> ttt 
plotit 11 >> ttt 
plotit 12 >> ttt 
plotit 13 >> ttt 
plotit 14 >> ttt 
plotit 15 >> ttt 
plotit 16 >> ttt 
plotit 17 >> ttt 
plotit 18 >> ttt 
plotit 19 >> ttt 
plotit 20 >> ttt 
plotit 21 >> ttt 
plotit 22 >> ttt 
plotit 23 >> ttt 
plotit 24 >> ttt 
plotit 25 >> ttt 
plotit 26 >> ttt 
plotit 27 >> ttt 
plotit 28 >> ttt 
plotit 29 >> ttt 
plotit 30 >> ttt 
plotit 31 >> ttt 
plotit 32 >> ttt 
plotit 33 >> ttt 
plotit 34 >> ttt 
plotit 35 >> ttt 
plotit 36 >> ttt 
plotit 37 >> ttt 
plotit 38 >> ttt 
plotit 39 >> ttt 


