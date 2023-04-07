#!/bin/sh
CONFIG=/etc/open5gs/nrf.yaml
if [ -z "$NRF_ADDR" ]; then
    NRF_ADDR="127.0.0.10 ::1"
fi
NRF_ADDR=`echo $NRF_ADDR | sed 's/ /\n        - /g'`
if [ -z "$NRF_PORT" ]; then
    NRF_PORT=7777
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "logger:
    file: /var/log/open5gs/nrf.log

nrf:
    sbi:
      - addr:
        - $NRF_ADDR
        port: $NRF_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT

parameter:

max:

time:
" > $CONFIG
/bin/open5gs-nrfd
