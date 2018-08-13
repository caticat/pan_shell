#!/bin/bash

# 快捷执行各种命令的脚本

# 所有命令
declare -A commands=()
commands["1"]="ls"
commands["2"]="dir"

# 常量配置
version="0.0.1"

# 参数校验
if [ $# -eq 0 ]; then
	echo "Pan's shell script, version[$version]"
	exit 0
fi

# 逻辑
case "$1" in
	haha)
		echo 1
		;;
	*)
		command=${commands[$1]}
		if [ -z $command ]; then
			echo "invalid command[$1]"
			exit 1
		else
			# echo $command
			$command
		fi
esac	

