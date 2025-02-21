#!/bin/bash

# 服务器启停

source "$path_libs/prsync.sh"

# regist ***********************************************************************

declare -A cmds=(); cmds_order=();
regist_cmd() { if [ "$#" -ne 3 ]; then echo "regist cmd failed: $*"; echo "use:"; echo -e "\tregist_cmd <command> <function> <description>"; exit 1; fi; local cmd=$1; local fn=$2; local desc=$3; cmds["$cmd"]="$fn, $desc"; cmds_order+=("$cmd"); }

# constants ********************************************************************

# commands *********************************************************************

# command, function, description
regist_cmd "simple" "test_simple" "test simple"
regist_cmd "rsync" "test_rsync" "test rsync"

# commands functions ***********************************************************

test_simple() {
	path="`dirname $0`"
	sh "$path/simple_test.sh"
}

test_rsync() {
	echo "empty test"
	# pupload "/p/tmp/a" "/home/abc/tmp/tmp" "abc@192.168.1.100" 22
	# pdownload "/home/abc/tmp/tmp" "/p/tmp/c" "abc@192.168.1.100" 22
}

# base functions ***************************************************************

help() {
	echo "Shortcut for shell command combinations"
	echo "Usage: $0 <command>"
	echo "Commands:"
	for cmd in "${cmds_order[@]}"; do
		echo -e "\t$cmd, ${cmds[$cmd]#* }"
	done
}
# main *************************************************************************

# check args
args_len=$#
if [ $args_len -eq 0 ]; then
	help
	exit 0
fi

# route commands
case "$1" in
	*)
		if [[ -z "$1" ]]; then
			help
			exit 0
		fi
		cmd=${cmds[$1]}
		if [ -z "$cmd" ]; then
			help
			exit 0
		fi

		cmd=${cmd%%,*}
		if [ $args_len -gt 1 ]; then
			args=$*
			args=${args#* }
			$cmd $args
		else
			$cmd
		fi
esac
