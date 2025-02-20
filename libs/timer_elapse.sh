#!/bin/bash

# 消耗时间

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
