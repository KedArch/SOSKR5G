#!/bin/sh
CONFIG=/etc/open5gs/ausf.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$AUSF_ADDR" ]; then
    AUSF_ADDR=127.0.0.11
fi
if [ -z "$AUSF_PORT" ]; then
    AUSF_PORT=7777
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$NRF_ADDR" ]; then
    NRF_ADDR=127.0.0.10
fi
if [ -z "$NRF_PORT" ]; then
    NRF_PORT=7777
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "logger:
    file: /var/log/open5gs/ausf.log

ausf:
    sbi:
      - addr: $AUSF_ADDR
        port: $AUSF_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT

nrf:
    sbi:
      - addr: $NRF_ADDR
        port: $NRF_PORT

parameter:

max:

time:
" > $CONFIG
/bin/open5gs-ausfd
