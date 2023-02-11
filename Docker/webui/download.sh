#!/bin/sh
cd $(dirname $0)
if ! [ -f Dockerfile ] || ! [ -d webui ]; then
    rm -rf Dockerfile webui
    git clone https://github.com/open5gs/open5gs
    mv open5gs/{webui,docker/webui/Dockerfile} .
    rm -rf open5gs
fi
