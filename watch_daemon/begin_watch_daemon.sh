#!/bin/bash

# 保证程序一直巡行,当程序不再运行时,自动启动程序,并报错

nohup ./watch_daemon_broom.sh 1>log_watch_broom.log 2>&1 &
nohup ./watch_daemon_kafka_consumer.sh 1>log_watch_kafka_consumer.log 2>&1 &
