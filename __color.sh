#Code 	Color 	Example 	Preview
COLOR_CLEAN="\e[0m"

#
#  FONT
#

# Bold
FONT_BOLD="\e[1m"
FONT_GRAY="\e[2m"
FONT_UNDERLINE="\e[4m"
FONT_STRIPE="\e[9m"

#
#  Forground color
#

#Code 	Color 	Example 	Preview
#39 	Default foreground color	echo -e ""Default \e[39mDefault"
COLOR_DEFAULT="\e[39m"
#30 	Black	echo -e ""Default \e[30mBlack"
COLOR_BLACK="\e[30m"
#31 	Red	echo -e ""Default \e[31mRed"
COLOR_RED="\e[31m"
#32 	Green	echo -e ""Default \e[32mGreen"
COLOR_GREEN="\e[32m"
#33 	Yellow	echo -e ""Default \e[33mYellow"
COLOR_YELLOW="\e[33m"
#34 	Blue	echo -e ""Default \e[34mBlue"
COLOR_BLUE="\e[34m"
#35 	Magenta	echo -e ""Default \e[35mMagenta"
COLOR_MAGENTA="\e[35m"
#36 	Cyan	echo -e ""Default \e[36mCyan"
COLOR_CYAN="\e[36m"
#37 	Light gray	echo -e ""Default \e[37mLight gray"
COLOR_LIGHT_GRAY="\e[37m"
#90 	Dark gray	echo -e ""Default \e[90mDark gray"
COLOR_DARK_GRAY="\e[90m"
#91 	Light red	echo -e ""Default \e[91mLight red"
COLOR_LIGHT_RED="\e[91m"
#92 	Light green	echo -e ""Default \e[92mLight green"
COLOR_LIGHT_GREEN="\e[92m"
#93 	Light yellow	echo -e ""Default \e[93mLight yellow"
COLOR_LIGHT_YELLOW="\e[93m"
#94 	Light blue	echo -e ""Default \e[94mLight blue"
COLOR_LIGHT_BLUE="\e[94m"
#95 	Light magenta	echo -e ""Default \e[95mLight magenta"
COLOR_LIGHT_MAGENTA="\e[95m"
#96 	Light cyan	echo -e ""Default \e[96mLight cyan"
COLOR_LIGHT_CYAN="\e[96m"
#97 	White	echo -e ""Default \e[97mWhite"
COLOR_LIGHT_WHITE="\e[97m"

#
#  Background color
#

#Code 	Color 	Example 	Preview
#49     Default background color	echo -e ""Default \e[49mDefault"
COLOR_BG_DEFAULT="\e[49m"
#30 	Black	echo -e ""Default \e[40mBlack"
COLOR_BG_BLACK="\e[40m"
#31 	Red	echo -e ""Default \e[41mRed"
COLOR_BG_RED="\e[41m"
#32 	Green	echo -e ""Default \e[42mGreen"
COLOR_BG_GREEN="\e[42m"
#33 	Yellow	echo -e ""Default \e[43mYellow"
COLOR_BG_YELLOW="\e[43m"
#34 	Blue	echo -e ""Default \e[44mBlue"
COLOR_BG_BLUE="\e[44m"
#35 	Magenta	echo -e ""Default \e[45mMagenta"
COLOR_BG_MAGENTA="\e[45m"
#36 	Cyan	echo -e ""Default \e[46mCyan"
COLOR_BG_CYAN="\e[46m"
#37 	Light gray	echo -e ""Default \e[47mLight gray"
COLOR_BG_LIGHT_GRAY="\e[47m"
#90 	Dark gray	echo -e ""Default \e[100mDark gray"
COLOR_BG_DARK_GRAY="\e[100m"
#91 	Light red	echo -e ""Default \e[101mLight red"
COLOR_BG_LIGHT_RED="\e[101m"
#92 	Light green	echo -e ""Default \e[102mLight green"
COLOR_BG_LIGHT_GREEN="\e[102m"
#93 	Light yellow	echo -e ""Default \e[103mLight yellow"
COLOR_BG_LIGHT_YELLOW="\e[103m"
#94 	Light blue	echo -e ""Default \e[104mLight blue"
COLOR_BG_LIGHT_BLUE="\e[104m"
#95 	Light magenta	echo -e ""Default \e[105mLight magenta"
COLOR_BG_LIGHT_MAGENTA="\e[105m"
#96 	Light cyan	echo -e ""Default \e[106mLight cyan"
COLOR_BG_LIGHT_CYAN="\e[106m"
#97 	White	echo -e ""Default \e[107mWhite"
COLOR_BG_LIGHT_WHITE="\e[107m"

function echo_clean
{
    echo -e "$COLOR_CLEAN"
}

function echo_red
{
    echo -e "$COLOR_RED$@$COLOR_DEFAULT"
}

function echo_green
{
    echo -e "$COLOR_GREEN$@$COLOR_DEFAULT"
}

function echo_yellow
{
    echo -e "$COLOR_YELLOW$@$COLOR_DEFAULT"
}

function echo_blue
{
    echo -e "$COLOR_BLUE$@$COLOR_DEFAULT"
}

function echo_magenta
{
    echo -e "$COLOR_MAGENTA$@$COLOR_DEFAULT"
}

function echo_cyan
{
    echo -e "$COLOR_CYAN$@$COLOR_DEFAULT"
}

function echo_light_gray
{
    echo -e "$COLOR_LIGHT_GRAY$@$COLOR_DEFAULT"
}

function echo_dark_gray
{
    echo -e "$COLOR_DARK_GRAY$@$COLOR_DEFAULT"
}

function echo_light_red
{
    echo -e "$COLOR_LIGHT_RED$@$COLOR_DEFAULT"
}

function echo_light_green
{
    echo -e "$COLOR_LIGHT_GREEN$@$COLOR_DEFAULT"
}

function echo_light_yellow
{
    echo -e "$COLOR_LIGHT_YELLOW$@$COLOR_DEFAULT"
}

function echo_light_blue
{
    echo -e "$COLOR_LIGHT_BLUE$@$COLOR_DEFAULT"
}

function echo_light_magenta
{
    echo -e "$COLOR_LIGHT_MAGENTA$@$COLOR_DEFAULT"
}

function echo_light_cyan
{
    echo -e "$COLOR_LIGHT_CYAN$@$COLOR_DEFAULT"
}

function echo_light_white
{
    echo -e "$COLOR_LIGHT_WHITE$@$COLOR_DEFAULT"
}


function echo_bg_red
{
    echo -e "$COLOR_BG_RED$@$COLOR_BG_DEFAULT"
}

function echo_bg_green
{
    echo -e "$COLOR_BG_GREEN$@$COLOR_BG_DEFAULT"
}

function echo_bg_yellow
{
    echo -e "$COLOR_BG_YELLOW$@$COLOR_BG_DEFAULT"
}

function echo_bg_blue
{
    echo -e "$COLOR_BG_BLUE$@$COLOR_BG_DEFAULT"
}

function echo_bg_magenta
{
    echo -e "$COLOR_BG_MAGENTA$@$COLOR_BG_DEFAULT"
}

function echo_bg_cyan
{
    echo -e "$COLOR_BG_CYAN$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_gray
{
    echo -e "$COLOR_BG_LIGHT_GRAY$@$COLOR_BG_DEFAULT"
}

function echo_bg_dark_gray
{
    echo -e "$COLOR_BG_DARK_GRAY$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_red
{
    echo -e "$COLOR_BG_LIGHT_RED$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_green
{
    echo -e "$COLOR_BG_LIGHT_GREEN$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_yellow
{
    echo -e "$COLOR_BG_LIGHT_YELLOW$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_blue
{
    echo -e "$COLOR_BG_LIGHT_BLUE$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_magenta
{
    echo -e "$COLOR_BG_LIGHT_MAGENTA$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_cyan
{
    echo -e "$COLOR_BG_LIGHT_CYAN$@$COLOR_BG_DEFAULT"
}

function echo_bg_light_white
{
    echo -e "$COLOR_BG_LIGHT_WHITE$@$COLOR_BG_DEFAULT"
}


