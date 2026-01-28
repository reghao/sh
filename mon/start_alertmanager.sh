#!/bin/bash

image="registry.cn-chengdu.aliyuncs.com/reghao/prom_alertmanager:v0.30.1"

host_confdir='/opt/docker/alertmanager/conf'
host_datadir='/opt/docker/alertmanager/data'
host_datadir1='/opt/docker/alertmanager/templates'

mkdir -p ${host_confdir}
mkdir -p ${host_datadir}
mkdir -p ${host_datadir1}
# 目录权限设置为所有人可 write
chmod -R go+w ${host_datadir}
chmod -R go+w ${host_datadir1}

host_conf=${host_confdir}'/alertmanager.yml'

docker run -d --name=alertmanager --restart=always --network=host \
    -v /etc/localtime:/etc/localtime:ro \
    -v ${host_conf}:/etc/alertmanager/alertmanager.yml  \
    -v ${host_datadir}:/opt/alertmanager/data \
    -v ${host_datadir1}:/opt/alertmanager/templates \
    ${image} --config.file=/etc/alertmanager/alertmanager.yml --storage.path=/opt/alertmanager/data --web.listen-address=:9093 --data.retention=120h
