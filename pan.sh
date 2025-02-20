#!/bin/bash

# regist ***********************************************************************

declare -A cmds=(); cmds_order=();
regist_cmd() { if [ "$#" -ne 3 ]; then echo "regist cmd failed: $*"; echo "use:"; echo -e "\tregist_cmd <command> <function> <description>"; exit 1; fi; local cmd=$1; local fn=$2; local desc=$3; cmds["$cmd"]="$fn, $desc"; cmds_order+=("$cmd"); }

# constants *********************************************************************

export path_current="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export path_apis="$path_current/apis"
export path_libs="$path_current/libs"

# commands *********************************************************************

# command, function, description
regist_cmd "ll" "list" "ls -al"
regist_cmd "v" "version" "show version"
regist_cmd "?" "help" "show help"
regist_cmd "test" "$path_apis/test.sh" "test api call"
regist_cmd "server" "$path_apis/general/server.sh" "server start|stop"
regist_cmd "uc" "$path_apis/general/update_client.sh" "update client"
regist_cmd "us" "$path_apis/general/update_server.sh" "update server [branch_name]"

# commands functions ***********************************************************

list() {
	ls -al
}

# base functions ***************************************************************

version() {
	echo "0.0.2"
}

help() {
	echo "Shortcut for shell command combinations"
	echo "Usage: $0 <command>"
	echo "Commands:"
	for cmd in "${cmds_order[@]}"; do
		echo -e "\t$cmd, ${cmds[$cmd]#* }"
	done
}

# utils ************************************************************************

Timer_start() {
    TIMER_START_TIME=$(date +%s)
}

Timer_stop() {
    TIMER_END_TIME=$(date +%s)
}

Timer_get_elapsed_time() {
    local elapsed_time=$((TIMER_END_TIME - TIMER_START_TIME))

    local days=$((elapsed_time / 86400))
    local hours=$(((elapsed_time % 86400) / 3600))
    local minutes=$(((elapsed_time % 3600) / 60))
    local seconds=$((elapsed_time % 60))

    local output=""
    if [ $days -gt 0 ]; then
        output="${days}天"
    fi
    if [ $hours -gt 0 ]; then
        output="${output}${hours}时"
    fi
    if [ $minutes -gt 0 ]; then
        output="${output}${minutes}分"
    fi
    if [ $seconds -gt 0 ]; then
        output="${output}${seconds}秒"
    fi

    echo "${output:-0秒}"
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

		Timer_start
		cmd=${cmd%%,*}
		if [ $args_len -gt 1 ]; then
			args=$*
			args=${args#* }
			$cmd $args
		else
			$cmd
		fi
		Timer_stop
		echo "Total time usage: $(Timer_get_elapsed_time)"
esac
