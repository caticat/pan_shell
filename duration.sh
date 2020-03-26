#!/bin/bash

# 消耗时间打印

GetDuration()
{
	timeSecond=$(($2-$1))
	timeDay=$(($timeSecond/(3600*24)))
	timeSecond=$(($timeSecond%(3600*24)))
	timeHour=$(($timeSecond/3600))
	timeSecond=$(($timeSecond%3600))
	timeMinute=$(($timeSecond/60))
	timeSecond=$(($timeSecond%60))

	retGetDuration=""
	if [ $timeDay != 0 ]; then
		retGetDuration="$retGetDuration$timeDay天"
	fi
	if [ $timeHour != 0 ]; then
		retGetDuration="$retGetDuration$timeHour时"
	fi
	if [ $timeMinute != 0 ]; then
		retGetDuration="$retGetDuration$timeMinute分"
	fi
	if [ $timeSecond != 0 ]; then
		retGetDuration="$retGetDuration$timeSecond秒"
	fi
	if [ ${#retGetDuration} == 0 ]; then
		retGetDuration="0秒"
	fi
}

retGetDuration=""
