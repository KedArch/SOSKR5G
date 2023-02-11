#!/bin/sh
CONFIG=/etc/open5gs/upf.yml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$PFCP_ADDR" ]; then
    PFCP_ADDR=127.0.0.7
fi
if [ -z "$GTPU_ADDR" ]; then
    GTPU_ADDR=127.0.0.7
fi
if [ -z "$SUBNET_ADDR" ]; then
    SUBNET_ADDR="10.45.0.1/16 2001:db8:cafe::1/48"
fi
SUBNET_ADDR=`echo $SUBNET_ADDR | sed 's/ /\n      - addr: /g'`
if [ -z "$METRICS_ADDR" ]; then
    METRICS_ADDR=127.0.0.7
fi
if [ -z "$METRICS_PORT" ]; then
    METRICS_PORT=9090
fi
printf "logger:
    file: @localstatedir@/log/open5gs/upf.log

upf:
    pfcp:
      - addr: $PFCP_ADDR
    gtpu:
      - addr: $GTPU_ADDR
    subnet:
      - addr: $SUBNET_ADDR
    metrics:
      - addr: $METRICS_ADDR
        port: $METRICS_PORT

smf:

parameter:

max:

time:
" > $CONFIG
/bin/open5gs-upfd