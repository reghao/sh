#!/bin/bash

image="registry.cn-chengdu.aliyuncs.com/reghao/prometheus:2.54.1"

host_confdir='/opt/docker/prometheus/conf'
host_datadir='/opt/docker/prometheus/data'
host_datadir1='/opt/docker/prometheus/rules'

mkdir -p ${host_confdir}
mkdir -p ${host_datadir}
mkdir -p ${host_datadir1}
# 目录权限设置为所有人可 write
chmod -R go+w ${host_datadir}
chmod -R go+w ${host_datadir1}

host_conf=${host_confdir}'/prometheus.yml'

docker run -d --name=prometheus --restart=always --network=host \
    -v /etc/localtime:/etc/localtime:ro \
    -v ${host_conf}:/etc/prometheus/prometheus.yml  \
    -v ${host_datadir1}:/etc/prometheus/rules  \
    -v ${host_datadir}:/prometheus \
    ${image} --config.file=/etc/prometheus/prometheus.yml --web.enable-admin-api \
    --storage.tsdb.retention=3d --web.enable-lifecycle
