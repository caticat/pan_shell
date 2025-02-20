#!/bin/bash

# 彩色输出

declare -A colors=(
    ["none"]="\033[0m"
    ["black"]="\033[0;30m"
    ["red"]="\033[31m"
    ["green"]="\033[0;32m"
    ["yellow"]="\033[0;33m"
    ["blue"]="\033[0;34m"
    ["purple"]="\033[0;35m"
    ["lightblue"]="\033[0;36m"
    ["white"]="\033[0;37m"
)

echo_green()
{
	echo -e "${colors['green']}$1${colors['none']}\c"
}
echo_green_n()
{
	echo -e "${colors['green']}$1${colors['none']}"
}

echo_yellow()
{
	echo -e "${colors['yellow']}$1${colors['none']}\c"
}
echo_yellow_n()
{
	echo -e "${colors['yellow']}$1${colors['none']}"
}

echo_red()
{
	echo -e "${colors['red']}$1${colors['none']}\c"
}
echo_red_n()
{
	echo -e "${colors['red']}$1${colors['none']}"
}
