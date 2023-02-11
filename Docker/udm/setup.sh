#!/bin/sh
CONFIG=/etc/open5gs/udm.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$UDM_ADDR" ]; then
    UDM_ADDR=127.0.0.12
fi
if [ -z "$UDM_PORT" ]; then
    UDM_PORT=7777
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "logger:
    file: /var/log/open5gs/udm.log

udm:
    sbi:
      - addr: $UDM_ADDR
        port: $UDM_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT


parameter:

max:

time:
" > $CONFIG
/bin/open5gs-udmd
