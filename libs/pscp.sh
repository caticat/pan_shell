#!/bin/bash

# 打包scp

# 上传
# @param string pathFrom
# @param string pathTo
# @param string remoteHost
# @param optional int remotePort
function pupload()
{
	if [ $# -lt 3 ]; then
		echo "invalid param num"
		exit 1
	fi
	local pathFrom=$1
	local pathTo=$2
	local remoteHost=$3
	local remotePort="22"
	if [ $# -gt 3 ]; then
		remotePort=$4
	fi
	# echo "f:$pathFrom;t:$pathTo;h:$remoteHost;p:$remotePort"

	# 临时文件
	local now=$(date +%s)
	local tmpFile="tmp$now.tar.bz2"
	cd $pathFrom
	tar -cjf $tmpFile *

	# 传输
	scp -P $remotePort $tmpFile $remoteHost:$pathTo

	# 清理本地
	rm $tmpFile

	# 解压 清理远程
	ssh $remoteHost -p $remotePort "cd $pathTo && tar -xjf $tmpFile -C . && rm $tmpFile"

	# 耗时计算
	local last=$(date +%s)
	echo "传输文件完成,耗时$((last - now))秒"
}

# 下载
# @param string pathFrom
# @param string pathTo
# @param string remoteHost
# @param optional int remotePort
function pdownload()
{
	if [ $# -lt 3 ]; then
		echo "invalid param num"
		exit 1
	fi
	local pathFrom=$1
	local pathTo=$2
	local remoteHost=$3
	local remotePort="22"
	if [ $# -gt 3 ]; then
		remotePort=$4
	fi
	# echo "f:$pathFrom;t:$pathTo;h:$remoteHost;p:$remotePort"

	# 临时文件
	local now=$(date +%s)
	local tmpFile="tmp$now.tar.bz2"
	ssh $remoteHost -p $remotePort "cd $pathFrom && tar -cjf $tmpFile *"

	# 传输
	cd $pathTo
	scp -P $remotePort $remoteHost:$pathFrom/$tmpFile .

	# 解压
	tar -xjf $tmpFile -C .

	# 清理本地
	rm $tmpFile

	# 清理远程
	ssh $remoteHost -p $remotePort "cd $pathFrom && rm $tmpFile"

	# 耗时计算
	local last=$(date +%s)
	echo "传输文件完成,耗时$((last - now))秒"
}
