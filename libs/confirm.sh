#!/bin/bash

# 确认函数

confirm_continue() {
    local message=${1:-"是否继续?"}
    echo -n "$message (y/Y 继续，其他退出): "
    read -r input
    if [[ "$input" != "y" && "$input" != "Y" ]]; then
        echo "❌ 操作已取消，程序退出。"
        exit 1
    fi
}
