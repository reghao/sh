#!/bin/bash

image="registry.cn-chengdu.aliyuncs.com/reghao/grafana_grafana-oss:11.2.2"

host_datadir='/opt/docker/grafana/data'
mkdir -p ${host_datadir}

docker run -d --name=grafana --restart=always --network=host \
    -u root --privileged=true \
    -v /etc/localtime:/etc/localtime:ro \
    -v ${host_datadir}:/var/lib/grafana \
    ${image}
