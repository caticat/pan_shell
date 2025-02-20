#!/bin/bash

# 服务器启停

# regist ***********************************************************************

declare -A cmds=(); cmds_order=();
regist_cmd() { if [ "$#" -ne 3 ]; then echo "regist cmd failed: $*"; echo "use:"; echo -e "\tregist_cmd <command> <function> <description>"; exit 1; fi; local cmd=$1; local fn=$2; local desc=$3; cmds["$cmd"]="$fn, $desc"; cmds_order+=("$cmd"); }

# constants ********************************************************************

base_path="/data/aabbcc/bbccaa/Build/Debug/bin"
server_name="aabbcc"

# commands *********************************************************************

# command, function, description
regist_cmd "start" "start_server" "sh start $server_name"
regist_cmd "stop" "stop_server" "sh stop $server_name"

# commands functions ***********************************************************

start_server() {
	cd $base_path
	sh start $server_name
	cd -
}

stop_server() {
	cd $base_path
	sh stop $server_name
	cd -
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
