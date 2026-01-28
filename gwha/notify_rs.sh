#!/bin/bash

###############################################################################
# LVS DR 转发模式下 RealServer 的事件通知
###############################################################################

realserver=$1
state=$2
api='http://192.168.0.147:4030/api/cluster/lvs/rs'

# 网卡名前缀
interface=enp0
host_addr=`ip a | grep inet | grep ${interface} | awk '{print $2}'`
host_addr1=`echo $host_addr | tr -s ' ' '_'`

payload='host='${host_addr1}'&realServer='${realserver}'&state='${state}
curl -d ${payload} ${api}