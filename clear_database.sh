#!/bin/bash

lib="$(dirname $0)/lib"
source $lib/show.sh
source $lib/duration.sh

showGreenN "开始清理数据库"
timeBegin=`date +%s`
hostIP="0.0.0.0"
hostPort="22"
mysqlPass="000000"

# 清理数据库
sql="SELECT table_name FROM information_schema.tables WHERE table_schema='databasename' AND table_name LIKE '%log%';"
arrTable=`ssh pan@$hostIP -p $hostPort "MYSQL_PWD=$mysqlPass mysql -uroot -e \"$sql\""`

counter=0
sql=""
for data in ${arrTable[@]}; do
	if [ "$data" != "table_name" ]; then
		counter=$(($counter+1))
		showGreen "删除表格:"
		showYellowN "$data"
		sql="$sql drop table databasename.$data;"
		if [ $(($counter % 100)) == 0 ]; then
			ssh pan@$hostIP -p $hostPort "MYSQL_PWD=$mysqlPass mysql -uroot -e \"$sql\""
			# echo $sql
			sql=""
		fi
	fi
done

if [ ${#sql} != 0 ]; then
	ssh pan@$hostIP -p $hostPort "MYSQL_PWD=$mysqlPass mysql -uroot -e \"$sql\""
	sql=""
fi

timeEnd=`date +%s`
GetDuration $timeBegin $timeEnd

showGreen "清理表格数量:"
showYellowN "$counter"
showGreen "使用时间:"
showYellow "$retGetDuration"
