#!/bin/bash

# 测试递归遍历文件夹

path="D:/pan/pan_shell"

function pwalk
{
	for file in `ls -A $1`; do
		if [ -d $1/$file ]; then
			pwalk $1/$file $2
		else
			$2 $1/$file
		fi
	done
}

function ptest
{
	echo "aaa" $1 "bbb"
}

pwalk $path ptest
