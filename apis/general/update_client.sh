#!/bin/bash

base_path="/D/home/pan/workspace/client"

ext_paths=(
    "clientproj"
    "clientproj/Assets/artres"
    "config"
    "config/AutoGen"
    "Resource"
    "ccaabb"
)

update()
{
    update_path=$1
    echo "updating: $update_path"

    cd "$update_path"

    git fetch --all
    git reset --hard origin/$(git branch --show-current)  # 强制重置为远程分支最新状态
    git clean -df

    git pull
}

update_all()
{
    for ext_path in "${ext_paths[@]}"; do
        update_path="$base_path/$ext_path"
        update $update_path
    done
}

update_all
