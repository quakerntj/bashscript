#!/bin/bash

#if import the path of arm-eabi-xxx will effect the build system
export PATH=$PATH:~/bashscript:~/bashscript/build_script:~/w/android_tools/:~/bin:~/w/device/sdk/tools/cpplint_forgaia

#for cscope to openfile
export EDITOR=gedit

#for bashscript color define
source __color.sh

alias sl='ls --color=auto'

#fast change dir
alias inc='. inc'
alias lang='. lang'
alias out='. out'
alias ga='. ga'
alias qa='. qa'
alias b='popd'
alias d='cd ..'
alias g='. g'
alias go='gnome-open'
alias gosmb='. gosmb'
alias adbl='adb logcat'
alias adbd='adb devices'
alias adblgsr='adb logcat *:S GSR:* InputReader:* GSRPlayer:*'
alias lpar='python2.7 ~/workspace/parser/parser.py'
alias pp='. pp'
alias bat='. bat'
alias cs='cscope'
alias cpplintf='cpplint_forgaia.py --filter=-runtime/int,-readability/variable_name,-build/header_guard,-build/include'
alias geidt='gedit'
alias llh='ll -h'

alias ban='. ban'
alias cbl='. ccbanl'
alias cml='. ccmml'

alias picl='. picl'
alias piclpwd='. picl "cd `pwd | sed s/src.*$//g`"'
alias picll='. picl l'
alias pisrv='. pipe_server'
alias gitmeld='meld'
alias du='du -h'

# Project shortcut
alias mr='cd ~/w/h/m7mr'
alias g15='cd ~/w/device'

alias shep='cd /media/w1/w/h/m7/cdtu'
alias jb41='cd /media/w2/jb41'
alias jb42='cd /media/w2/jb42'
alias jb43='cd /media/w2/jb43'
alias jb44='cd /media/w2/jb44'

alias ff='find . -name'
alias ffg='find . -iregex'

alias cdp='cd `pwd -P`'

function gettop()
{ 
    local TOPFILE=build/core/envsetup.mk;
    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ]; then
        echo $TOP;
    else
        if [ -f $TOPFILE ]; then
            /bin/pwd;
        else
            local HERE=$PWD;
            T=;
            while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
                cd .. > /dev/null;
                T=`PWD= /bin/pwd`;
            done;
            cd $HERE > /dev/null;
            if [ -f "$T/$TOPFILE" ]; then
                echo $T;
            fi;
        fi;
    fi
}


function qatop()
{
    export QA_TOP=`pwd`
}

function trc()
{
    if [[ "$1" == "i" ]]; then
        shift
        local TR_SAME_NAME=1
    fi
    if [[ -f "$1" ]]; then
        gedit "$TRED_FILE"
        local TR_FILE="$1"
        local TRED_FILE="$1.txt"
        cat $TR_FILE | tr -cd "[:print:]\n\t"> $TRED_FILE
        if [[ $TR_SAME_NAME -eq 1 ]]; then
            mv $TRED_FILE $TR_FILE
            gedit $TR_FILE
        else
            gedit $TRED_FILE
        fi
    fi
}

function kgrep()
{
    find . -type f -iregex '.*\.\(c\|h\|cpp\|java\|mk\)' -print0 | xargs -0 grep --color -n "$@"
}

function lgrep()
{
    find . -type f -iregex '.*\(dlog\|device\).*' -print0 | xargs -0 grep --color -n "$@"
}

function tgrep()
{
    local TMP_OPTIND=$OPTIND
    OPTIND=1
    while getopts "t" name
    do
        case $name in
        "t")
            find . -type f -iregex '.*/tombstone_.*' -print0 | xargs -0 grep --color -n ">>>.*<<<" | sort
            return 0;;
        esac
    done
    OPTIND=$TMP_OPIND
    find . -type f -iregex '.*/tombstone_.*' -print0 | xargs -0 grep --color -n "$@"
}

function mgrep()
{
    find . -type f -iregex '.*/\(Makefile\|Makefile\..*\|.*\.make\|.*\.mak\|.*\.mk\)' -print0 | xargs -0 grep --color -n "$@"
}

function hgrep()
{
    find . -type f -iregex '.*\.h' -print0 | xargs -0 grep --color -n "$@"
}

function one_godir() 
{
    if [[ -z "$1" ]]; then
        return 1;
    fi;

    local lines;
    lines=($(grep "$1" $T/filelist));
    if [[ ${#lines[@]} = 0 ]]; then
        echo found 0 results.
        return 0;
    fi;
    local pathname;
    local choice;
    if [[ ${#lines[@]} > 1 ]]; then
        echo found ${#lines[@]} results.
        return 3;
    else
        pathname=${lines[0]};
    fi;
    echo $T/$pathname
}

function gfilelist()
{ 
    T=$(gettop);
    echo -n "Creating index...";
    cd $T;
    find . -wholename ./vendor -prune -o -wholename ./prebuilt -prune -o -wholename ./prebuilts -prune -o -wholename ./out -prune -o -wholename ./bsp_generic -prune -o -wholename ./sdk_release -prune -o -wholename ./.ccache -prune -o -wholename ./.repo -prune -o -type f > filelist;
    #find . -wholename ./out -prune -o -wholename ./sdk -prune -o -wholename ./bsp_generic -prune -o -wholename sdk_release -prune -o -wholename ./.ccache -prune -o -wholename ./.repo -prune -o -type f > filelist;
    echo " Done";
    echo "";
}

function meldd()
{
    if [[ $# -eq 3 ]]; then
        # remove tail '/'
        local ROOT1="${1%/}"
        local ROOT2="${2%/}"
        local COMMON_PATH="${3%/}"
        # if the $3 exist maybe contain the root1 or root2
        if [ -e $3 ]; then 
            COMMON_PATH=${COMMON_PATH#$1}
            COMMON_PATH=${COMMON_PATH#$2}
        fi
        if [ ! -e $ROOT1/$COMMON_PATH ]; then
            echo $ROOT1/$COMMON_PATH not exist
            return 2;
        fi
        if [ ! -e $ROOT2/$COMMON_PATH ]; then
            echo $ROOT2/$COMMON_PATH not exist
            return 2;
        fi
        meld $ROOT1/$COMMON_PATH $ROOT2/$COMMON_PATH
    fi
}

function melddd()
{
    if [[ $# -eq 4 ]]; then
        # remove tail '/'
        local ROOT1="${1%/}"
        local ROOT2="${2%/}"
        local ROOT3="${2%/}"
        local COMMON_PATH="${3%/}"
        # if the $3 exist maybe contain the root1 or root2
        if [ -e $3 ]; then 
            COMMON_PATH=${COMMON_PATH#$1}
            COMMON_PATH=${COMMON_PATH#$2}
            COMMON_PATH=${COMMON_PATH#$3}
        fi
        if [ ! -e $ROOT1/$COMMON_PATH ]; then
            echo $ROOT1/$COMMON_PATH not exist
            return 2;
        fi
        if [ ! -e $ROOT2/$COMMON_PATH ]; then
            echo $ROOT2/$COMMON_PATH not exist
            return 2;
        fi
        if [ ! -e $ROOT3/$COMMON_PATH ]; then
            echo $ROOT3/$COMMON_PATH not exist
            return 2;
        fi
        meld $ROOT1/$COMMON_PATH $ROOT2/$COMMON_PATH $ROOT3/$COMMON_PATH
    fi
}

function isScreenOn()
{
    #IPowerManager::isScreenOn = 14
    adbs service call power 14 | grep 00000001 -q
    
    #if ScreenOn, grep will return 0.  So we sould inverse it.
    return $?
}

function adbDevices() {
    local DAILY_ADB_DEVICES=`adb devices | grep -v List | grep device | wc -l`
    if [ $DAILY_ADB_DEVICES -eq 1 ]; then
        DAILY_ADB_DEVICES=1
    else
        DAILY_ADB_DEVICES=0
    fi
    return $DAILY_ADB_DEVICES
}

function dai()
{

    local DAILY_YESTERDAY=`date --date="yesterday" +%m%d`
    local DAILY_ROOT_FOLDER="/media/w1/log/daily"
    local DAILY_FOLDER="$DAILY_ROOT_FOLDER/$DAILY_YESTERDAY"
    if [ ! -d "$DAILY_FOLDER" ]; then
        mkdir "$DAILY_FOLDER"
    fi
    if [ "$1" != "" ]; then
        if [ -d "$DAILY_ROOT_FOLDER/$1" ]; then
            DAILY_FOLDER=$DAILY_ROOT_FOLDER/$1
            DAILY_YESTERDAY=$1
            shift
        fi
    fi
    echo "DAILY FOLDER=$DAILY_FOLDER"
    local TMP_OPTIND=$OPTIND
    OPTIND=1
    while getopts "mzpbshc" opname
    do
        case $opname in
        "m")
            adb shell monkey -s `date +%s` 500000
            isScreenOn
            #if ScreenOn, grep will return 0.  So we sould inverse it.
            if [ ! $? ]; then
                echo "Send power key to light on screen"
                adb shell input keyevent 26
            fi
            return;;
        "z")
            local DAILY_TAR_XZ="$DAILY_YESTERDAY.tar.xz"
            pushd . > /dev/null
            cd $DAILY_FOLDER/..
            echo "tar -Jcf \"$DAILY_YESTERDAY.tar.xz\" \"$DAILY_YESTERDAY\""
            tar -Jcf "$DAILY_TAR_XZ" "$DAILY_YESTERDAY"
            echo "file:///$DAILY_ROOT_FOLDER/$DAILY_TAR_XZ"

            echo "Open StressTest share folder..."
            nautilus smb://htctpena1.htc.com.tw/gpd000/GPD130/Stress_Test/Peripheral/Quaker_Chung
            echo "Open ZIP folder"
            nautilus .
            popd > /dev/null
            return;;
        "p")
            # let user check the path
            sleep 2

            local DAILY_ADB_DEVICES=`adb devices | grep -v List | grep device | wc -l`
            if [ $DAILY_ADB_DEVICES -eq 1 ]; then
                pushd . > /dev/null
                cd $DAILY_FOLDER
                adb pull /data/tombstones
                adb pull /data/htclog
                adb pull /data/log
                adb pull /storage/sdcard0/htclog
                adb pull /data/anr
                tgrep -t
            else
                echo  -e $COLOR_RED"Need connect to one device."$COLOR_DEFAULT
            fi
            return;;
        "b")
            pushd . > /dev/null
            cd $DAILY_FOLDER
            head tombstone_* -n 38 | grep -e backtrace -A4
            return;;
        "s")
            echo "Open StressTest share folder..."
            nautilus smb://htctpena1.htc.com.tw/gpd000/GPD130/Stress_Test/Peripheral/Quaker_Chung
            echo "Open ZIP folder"
            nautilus .
            return;;
        "c")
            adbs rm "/data/log/*"
            adbs rm "/data/tombstones/tomb*"
            adbs rm "/data/htclog/*"
            adbs rm "/data/anr"
            return;;
        "h")
            echo "$ dai [MMDD] [-<[mzpbshc]>]"
            echo "Goto the daily test folder.  The "dai" Can pull log from devices,"
            echo "archive log, show backtrace, and run monkey test."
            echo "    MMDD   - the date you want to process."
            echo "             If not specified, use the the date of yesterday"
            echo "    m      - run monkey test"
            echo "    z      - archive the log folder as MMDD.tar.xz"
            echo "    p      - adb pull logs"
            echo "    b      - show backtrace of tombstones"
            echo "    s      - show share folder on SAMBA, and local folder"
            echo "    c      - rm log, htclog, anr, tombstones in /data"
            echo "example:"
            echo "$ dai"
            echo "$ dai -p"
            echo "$ dai 1110 -z"
            echo "$ dai -z"
            echo "$ dai 1110"
            echo "$ dai -m"
            echo "$ dai -b"
        esac
    done
    OPTIND=$TMP_OPIND

    pushd . > /dev/null
    cd $DAILY_FOLDER
}

function issue()
{
    local ISSUE_ROOT_FOLDER="/media/w1/log/issue"
    if [ $# -eq 0 ]; then
        ls -tl $ISSUE_ROOT_FOLDER
        return
    fi

    local ISSUE_FOLDER="$ISSUE_ROOT_FOLDER/$1"
    if [ ! -d "$ISSUE_FOLDER" ]; then
        mkdir "$ISSUE_FOLDER"
    fi

    pushd . > /dev/null
    cd $ISSUE_FOLDER
}

#function tcsGetContent()
#{
#    awk -v regexp='^\['$2'\]' '
#        {RS=\n\n}
#        $0 ~ regexp {print $0; print '\n'}' $1
#}

function tcsGetContentFromList()
{
    LEAK=$1
    LIST=$2
    if [ -f "$LEAK" -a -f "$LIST" ]; then
        echo
    else
        echo Synctax error
        return 1
    fi

    while read line
    do
        tcsGetContent $LEAK `echo $line | awk '{print $2}'`
    done < "$LIST"
}

function tcsGrep() {
    local FILENAME=$1
    shift
    local MAX_INDEX=`grep "\[[0-9]*\] A" $FILENAME | wc -l`
    local i=1
    while [ $i -lt $MAX_INDEX ];
    do
        local CONTENT=`tcsGetContent $FILENAME $i`
        if [ "$CONTENT" == "" ]; then
            i=`expr $i + 1`
            continue
        fi
        echo $CONTENT | grep -q $@
        if [ $? -eq 0 ]; then
            echo "$CONTENT"
            echo ""
        fi
        i=`expr $i + 1`
    done
}

function tcsAddNewLine () {
    cat $@ | awk '/^Alloc/ {print ""} {print $0}'
}

function tcsSort()
{
    local FILENAME=$1
    grep "\[[0-9]*\] A" $FILENAME | \
        sed 's/^\[\([0-9]*\)\].*Objects \([0-9]*\)->\([0-9]*\), Increment.*$/\3 \1/g' | sort -g -r
}

function tcsSortContent()
{
    local FILENAME=$1
    grep "\[[0-9]*\] A" $FILENAME | \
        sed 's/^\[\([0-9]*\)\].*Objects \([0-9]*\)->\([0-9]*\), Increment.*$/\3 \1/g' | \
        sort -g -r | \
        sed 's/[0-9]* \([0-9]*\)/\1\n/g' | \
        xargs -n1 tcsGetContent $FILENAME 
}

function chapi()
{
    test -f Gaia.xml -a -f Gaia.mk
    if [[ $? -ne 0 ]]; then
        echo "No Gaia.xml and src/Gaia.mk"
    fi
    grep api Gaia.xml
}


function gg () 
{ 
    if [[ -z "$1" ]]; then
        echo "Usage: gg <regex>";
        return;
    fi;
    T=$(gettop);
    if [[ ! -f $T/filelist ]]; then
        echo -n "No index...";
        return;
    fi;
    local lines;
    lines=($(\grep "$1" $T/filelist | sed -e 's/\/[^/]*$//' | sort | uniq));
    if [[ ${#lines[@]} = 0 ]]; then
        echo "Not found";
        return;
    fi;
    local pathname;
    local choice;
    if [[ ${#lines[@]} > 1 ]]; then
        while [[ -z "$pathname" ]]; do
            local index=1;
            local line;
            for line in ${lines[@]};
            do
                printf "%6s %s\n" "[$index]" $line;
                index=$(($index + 1));
            done;
            echo;
            echo -n "Select one: ";
            unset choice;
            read choice;
            if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
                echo "Invalid choice";
                continue;
            fi;
            pathname=${lines[$(($choice-1))]};
        done;
    else
        pathname=${lines[0]};
    fi;
    cd $T/$pathname

    local BASENAME=`basename $1`
    match=`ls | grep "^$BASENAME" | wc -l`
    if [[ $match -eq 1 ]]; then
        gedit `ls | grep "^$BASENAME"`
    else
        echo "matched:"
        ls | grep "^$BASENAME"
    fi
}

function frb()
{
    local FASTBOOT_REBOOT=reboot
    local TMP_OPTIND=$OPTIND
    OPTIND=1
    while getopts "h" name
    do
        case $name in
        "h")
            echo "frb [-b|-R]"
            echo "frb [b|R]"
            echo "-b   : reboot-bootloader"
            echo "-R   : oem rebootRUU";;
        "b")
            FASTBOOT_REBOOT=reboot-bootloader;;
        "R")
            FASTBOOT_REBOOT="oem rebootRUU";;
        esac
    done
    OPTIND=$TMP_OPIND

    if [ "$1" == "b" ]; then
        FASTBOOT_REBOOT=reboot-bootloader
    fi
    if [ "$1" == "R" ]; then
        FASTBOOT_REBOOT="oem rebootRUU"
    fi
    echo "fastboot $FASTBOOT_REBOOT"
    fastboot $FASTBOOT_REBOOT
}

function fb()
{
    local TMP_OPTIND=$OPTIND
    OPTIND=1
    while getopts "z" name
    do
        case $name in
        "z")
            echo zip boot.zip -j boot.img android-info.txt
            zip boot.zip -j boot.img android-info.txt
            fastboot flash zip boot.zip
            rm boot.zip
            return 0;;
        esac
    done
    OPTIND=$TMP_OPIND

    fastboot flash boot boot.img
}

function ccdir()
{
    if [ "$TARGET_PRODUCT" == "" -o "$TARGET_BUILD_VARIANT" == "" ]; then
        echo "need \$TARGET_PRODUCT and \$TARGET_BUILD_VARIANT"
        return;
    fi
    pushd . > /dev/null
    cd $(gettop)
    local LOCAL_DIR=`pwd -P`
    popd > /dev/null
    local CC_DIR=/media/w3/ccache/`md5pass $LOCAL_DIR $TARGET_PRODUCT/$TARGET_BUILD_VARIANT | sed 's/[\$\/\.]//g'`
    TMP_OPTIND=$OPTIND
    OPTIND=1
    while getopts "mgrl" name
    do
        case $name in
        "m")
            if [ ! -d $CC_DIR ]; then
                mkdir $CC_DIR
            fi
            echo "$LOCAL_DIR $TARGET_PRODUCT/$TARGET_BUILD_VARIANT > $CC_DIR/README"
            echo "$LOCAL_DIR $TARGET_PRODUCT/$TARGET_BUILD_VARIANT" > $CC_DIR/README
            break;;
        "g")
            cd $CC_DIR
            break;;
        "l")
            #cat /media/w3/ccache/*/README 2> /dev/null
            for line in `ls -1 /media/w3/ccache`
            do
                echo "`cat /media/w3/ccache/$line/README 2>/dev/null`  $line"
            done
            return
            break;;
        "r")
            echo "rm -rI $CC_DIR"
            rm -rI $CC_DIR
            break;;
        esac
    done
    OPTIND=$TMP_OPIND
    echo $CC_DIR
}

function vendorchk {
    if [ ! -d vendor ]; then
        echo "Need in root folder"
        return
    fi
    echo chk vendor/htc/QXDM2SD/
    cd vendor/htc/QXDM2SD/
    git chk .
    cd -
    
    echo chk vendor/htc/SsdTestTool/
    cd vendor/htc/SsdTestTool/
    git chk .
    cd -
    
    echo chk vendor/htc/GaiaTools/
    cd vendor/htc/GaiaTools/
    git chk .
    cd -
    
    echo chk vendor/htc/CruiserPwrExpert/
    cd vendor/htc/CruiserPwrExpert/
    git chk .
    cd -

    echo chk vendor/htc/UserTrialFeedback/
    cd vendor/htc/UserTrialFeedback/
    git chk .
    cd -
}

function uagcc {
    sudo update-alternatives --config gcc
}

source buildkernel

shopt -s dirspell
shopt -s cdspell

function ParseTags()
{
    echo "Start finding possible LOG_TAG"
    echo > Tags
    ls device_* | while read line
        do
            echo $line
            sed 's/^..-.. ..:..:......\s*[0-9]*\s*[0-9]*\s*.\s\([0-9A-Za-z_\s-\.]*\)\s*: .*/\1/g' $line >> Tags
        done
        
    cat Tags | uniq > Tags.uniq
    cat Tags.uniq | sort | uniq > Tags.sort.uniq

    echo "Start finding each LOG_TAG from log"
    echo > Tags.count
    while read tag
    do
        echo $tag
        echo $tag | grep "[\[]" -q
        
        if [[ $? -ne 0 ]]; then
            echo $tag >> Tags.count
            grep -hc "^..-.. ..:..:......\s*[0-9]*\s*[0-9]*\s*.\s$tag\s*:" device_* >> Tags.count
        else
            echo "----- skip $tag -----"
        fi
    done < "Tags.sort.uniq"

#    countparser Tags.count > Tags.count.sum
#    cat Tags.count.sum | sort -n > Tags.count.sum.sort
}

function gerrit {
    # http://gerrit.googlecode.com/svn/documentation/2.2.1/index.html
    # Modify the user_name corresponded to your gerrit setting. (need SSH)
    # Author: Quaker Chung
    local USER_NAME="quaker_chung"
    local REVIEWER=" reviewer:$USER_NAME "
    local PORT="29419"
    local GERRIT="git.htc.com"
    local TMP_OPTIND=$OPTIND
    OPTIND=1
    local ACTION=
    local SUB_ACTION=
    local NUMBER=
    local OWNER=
    local PATCH=1
    while getopts "mR:rlLPp:n:o:uh" name
    do
        case $name in
        "m")
            REVIEWER="";;
        "R")
            REVIEWER=" reviewer:$OPTARG ";;
        "L")
            if [ "$ACTION" != "" ]; then
                echo "Only allow one action"
                return 1
            fi
            ACTION="listN";;
        "l")
            if [ "$ACTION" != "" ]; then
                echo "Only allow one action"
                return 1
            fi
            ACTION="list";;
        "r")
            if [ "$ACTION" != "" ]; then
                echo "Only allow one action"
                return 1
            fi
            ACTION="review";;
        "p")
            if [ "$ACTION" != "" ]; then
                echo "Only allow one action"
                return 1
            fi
            ACTION="pipe";;
        "N")
            SUB_ACTION="dry";;
        "n")
            NUMBER="$OPTARG";;
        "p")
            PATCH="$OPTARG";;
        "o")
            OWNER=" owner:$OPTARG ";;
        "h")
            echo "gerrit -rlLPp:n:";;
        "u")
            # Custom command
            shift
            echo $@
            ssh -p $PORT $USER_NAME@$GERRIT $@
            return
        esac
    done
    OPTIND=$TMP_OPIND
    case $ACTION in
    "listN")
            #echo "ssh -p $PORT $USER_NAME@git.htc.com 'gerrit query status:open reviewer:$USER_NAME$OWNER' | grep number | cut -d\" \" --fields 4"
            ssh -p $PORT $USER_NAME@$GERRIT 'gerrit query status:open '$REVIEWER$OWNER | grep number | cut -d" " --fields 4
            ;;
    "list")
            echo "ssh -p $PORT $USER_NAME@git.htc.com 'gerrit query status:open $REVIEWER$OWNER'"
            ssh -p $PORT $USER_NAME@$GERRIT 'gerrit query status:open '$REVIEWER$OWNER
            ;;
    "review")
        if [ "$NUMBER" == "" ]; then
            echo "need enter patch number"
            return 1
        fi
        echo ssh -p $PORT $USER_NAME@$GERRIT 'gerrit review --submit --verified +1 --code-review +2  --message "SRD: Y" '$NUMBER','$PATCH
        if [ "$SUB_ACTION" != "dry" ]; then
        ssh -p $PORT $USER_NAME@$GERRIT 'gerrit review --submit --verified +1 --code-review +2  --message "SRD: Y" '$NUMBER','$PATCH
        fi
        ;;
    "pipe")
        echo "ssh -p $PORT $USER_NAME@$GERRIT 'gerrit query status:open reviewer:$USER_NAME$OWNER' | grep number | cut -d" " --fields 4 | xargs -0 gerrit -r -n"
        if [ "$SUB_ACTION" != "dry" ]; then
        ssh -p $PORT $USER_NAME@$GERRIT 'gerrit query status:open reviewer:'$USER_NAME$OWNER | grep number | cut -d" " --fields 4 | xargs -0 gerrit -r -n
        fi
        ;;
    esac
}


# For repo init
#repo init -u ssh://$ID@$MIRROR:29419/manifest.git -b htc -m gaia_manifest.xml
export ID=quaker_chung
export MIRROR=tpe.git.htc.com

