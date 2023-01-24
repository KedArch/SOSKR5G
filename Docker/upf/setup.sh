#!/bin/sh
if [ -n "$PFCP_ADDR" ]; then
    sed -z -i "s/\(upf:\n[^#]*pfcp:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $PFCP_ADDR/" /etc/open5gs/upf.yaml
fi
if [ -n "$GTPU_ADDR" ]; then
    sed -z -i "s/\(upf:\n[^#]*gtpu:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $GTPU_ADDR/" /etc/open5gs/upf.yaml
fi
if [ -n "$METRICS_ADDR" ]; then
    sed -z -i "s/\(upf:\n[^#]*metrics:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $METRICS_ADDR/" /etc/open5gs/upf.yaml
fi
if [ -n "$SUBNET_ADDR" ]; then
    sed -z -i "s/\(upf:\n[^#]*subnet:\n *[-]\{0,1\} addr:\) [0-9\/.]\{1,\}/\1 $SUBNET_ADDR/" /etc/open5gs/upf.yaml
fi
/bin/open5gs-upfd
