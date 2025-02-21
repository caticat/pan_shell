#!/bin/bash

echo "!!!,0:$0,1:$1,2:$2,3:$3,@:$@,?:$?,#:$#"

source "$path_libs/echo_color.sh"
source "$path_libs/timer_elapse.sh"
source "$path_libs/confirm.sh"

Timer_start

confirm_continue
echo "continue 1"
confirm_continue "是否继续!!??@@"
echo "continue 2"

Timer_stop
Timer_get_elapsed_time

echo_green_n "hahaha"
