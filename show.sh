#!/bin/bash

# 颜色打印

declare -A colors=(["none"]="\033[0m" ["black"]="\033[0;30m" ["red"]="\033[31m" ["green"]="\033[0;32m" ["yellow"]="\033[0;33m" ["blue"]="\033[0;34m" ["purple"]="\033[0;35m" ["lightblue"]="\033[0;36m" ["white"]="\033[0;37m")
showGreen()
{
	echo -e "${colors['green']}$1${colors['none']}\c"
}
showGreenN()
{
	echo -e "${colors['green']}$1${colors['none']}"
}
showYellow()
{
	echo -e "${colors['yellow']}$1${colors['none']}\c"
}
showYellowN()
{
	echo -e "${colors['yellow']}$1${colors['none']}"
}
showRed()
{
	echo -e "${colors['red']}$1${colors['none']}\c"
}
showRedN()
{
	echo -e "${colors['red']}$1${colors['none']}"
}