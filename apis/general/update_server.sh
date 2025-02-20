#!/bin/bash

# 更新本地代码

source "$path_libs/confirm.sh"

base_path="/p/workspace"

ext_paths=(
    "bbccaa"
    "ccbbaa"
)

branch=${1:-"develop_aabbcc"}

switch_branch()
{
    # 检查远程是否存在该分支
    if git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
        echo "远程分支 origin/$branch 存在"
    else
        echo "❌ 远程分支 origin/$branch 不存在，操作终止"
        return 1
    fi

    # 检查本地是否已有该分支
    if git rev-parse --verify "$branch" >/dev/null 2>&1; then
        echo "本地已有分支 $branch，切换到该分支..."
        git checkout "$branch"
    else
        echo "本地无分支 $branch，创建并追踪远程分支..."
        git checkout -b "$branch" --track "origin/$branch"
    fi

    return 0
}

update()
{
    update_path=$1
    echo "updating: $update_path"

    cd "$update_path"

    switch_branch
    if [[ $? -ne 0 ]]; then
        echo "❌ 远程分支不存在，切换分支失败[$update_path]"
    fi

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

confirm_continue "即将切换到分支: $branch, 请确保已提交所有本地修改, 否则将丢弃本地所有变更."
update_all
