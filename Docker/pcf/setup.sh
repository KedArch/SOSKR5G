#!/bin/sh
CONFIG=/etc/open5gs/pcf.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$DB_URI" ]; then
    DB_URI=mongodb://localhost/open5gs
fi
if [ -z "$PCF_ADDR" ]; then
    PCF_ADDR=127.0.0.13
fi
if [ -z "$PCF_PORT" ]; then
    PCF_PORT=7777
fi
if [ -z "$METRICS_ADDR" ]; then
    METRICS_ADDR=127.0.0.13
fi
if [ -z "$METRICS_PORT" ]; then
    METRICS_PORT=9090
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "db_uri: $DB_URI

logger:
    file: /var/log/open5gs/pcf.log

pcf:
    sbi:
      - addr: $PCF_ADDR
        port: $PCF_PORT
    metrics:
      - addr: $METRICS_ADDR
        port: $METRICS_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT


parameter:

max:

time:
" > $CONFIG
/bin/open5gs-pcfd
