#!/bin/bash

# 保证程序一直巡行,当程序不再运行时,自动启动程序,并报错

watchProcess="kafka_consumer kafka_consumer_config"
startProcess="nohup ./kafka_consumer -config=../config/kafka_consumer_config.xml 1>/dev/null 2>&1 &"

retHasProcess=0
hasProcess()
{
	local cmd="eval ps x "
	for i in $*; do
		cmd=$cmd"| grep \"$i\" "
	done
	cmd=$cmd"| grep -v grep"
	local result=$($cmd)
	# echo "--------->$result"
	if [ ${#result} != 0 ]; then
		retHasProcess=1
	else
		retHasProcess=0
	fi
}

echo "[`date`]begin watch process [$watchProcess]"

while [ true ]; do
	hasProcess $watchProcess
	if [ $retHasProcess == 0 ]; then
		eval $startProcess
		echo "[`date`]try restart [$watchProcess]"
	fi
	sleep 60
done

echo "[`date`]done"
