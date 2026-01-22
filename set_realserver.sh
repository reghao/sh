#!/bin/bash

###############################################################################
# LVS DR 转发模式下在 RealServer 上的设置
###############################################################################

# 虚拟 IP
virtual_ip=192.168.0.190
# 绑定到 lo 网卡
interface=lo
ifconfig ${interface}:0 ${virtual_ip} broadcast ${virtual_ip} netmask 255.255.255.255 up
route add -host ${virtual_ip} dev ${interface}:0

# 关闭 arp 查询响应
echo "1" > /proc/sys/net/ipv4/conf/${interface}/arp_ignore
echo "2" > /proc/sys/net/ipv4/conf/${interface}/arp_announce
echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore
echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce