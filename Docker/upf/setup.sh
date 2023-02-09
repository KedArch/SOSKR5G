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
if [ -z "$METRICS_ADDR" ]; then
    METRICS_ADDR=127.0.0.7
fi
if [ -z "$METRICS_PORT" ]; then
    METRICS_PORT=9090
fi
printf "logger:\n  file: @localstatedir@/log/open5gs/upf.log" > $CONFIG
printf "\n\nupf:\n  pcfp:\n" >> $CONFIG
echo "    - addr: $PFCP_ADDR" >> $CONFIG
echo "  gtpu:" >> $CONFIG
echo "    - addr: $GTPU_ADDR" >> $CONFIG
echo "  subnet:" >> $CONFIG
for I in $SUBNET_ADDR; do
    echo "    - addr: $I" >> $CONFIG
done
echo "  metrics:" >> $CONFIG
echo "    - addr: $METRICS_ADDR" >> $CONFIG
echo "      port: $METRICS_PORT" >> $CONFIG
printf "\nsmf:\n\nparameter:\n\nmax:\n\ntime:" >> $CONFIG
/bin/open5gs-upfd
