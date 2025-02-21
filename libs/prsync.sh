#!/bin/bash

# 远程上传
# @param string pathFrom
# @param string pathTo
# @param string remoteHost
# @param optional int remotePort
# @example pupload "/local/path" "/remote/path" "192.168.1.100" 22
# @example pupload "/local/path" "/remote/path" "dev@192.168.1.100" 22
function pupload()
{
    if [ $# -lt 3 ]; then
        echo "invalid param num"
        exit 1
    fi
    local pathFrom=$1
    local pathTo=$2
    local remoteHost=$3
    local remotePort="22"
    if [ $# -gt 3 ]; then
        remotePort=$4
    fi

    local now=$(date +%s)

    # rsync 上传
    rsync -avz -e "ssh -p $remotePort" "$pathFrom/" "$remoteHost:$pathTo"

    local last=$(date +%s)
    echo "上传完成, 耗时$((last - now))秒"
}

# 远程下载
# @param string pathFrom
# @param string pathTo
# @param string remoteHost
# @param optional int remotePort
# @example pdownload "/remote/path" "/local/path" "192.168.1.100" 22
# @example pdownload "/remote/path" "/local/path" "dev@192.168.1.100" 22
function pdownload()
{
    if [ $# -lt 3 ]; then
        echo "invalid param num"
        exit 1
    fi
    local pathFrom=$1
    local pathTo=$2
    local remoteHost=$3
    local remotePort="22"
    if [ $# -gt 3 ]; then
        remotePort=$4
    fi

    local now=$(date +%s)

    # rsync 下载
    rsync -avz -e "ssh -p $remotePort" "$remoteHost:$pathFrom/" "$pathTo"

    local last=$(date +%s)
    echo "下载完成, 耗时$((last - now))秒"
}
