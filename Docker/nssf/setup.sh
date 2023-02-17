#!/bin/sh
CONFIG=/etc/open5gs/nssf.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$NSSF_ADDR" ]; then
    NSSF_ADDR=127.0.0.14
fi
if [ -z "$NSSF_PORT" ]; then
    NSSF_PORT=7777
fi
if [ -z "$NSI_ADDR" ]; then
    NSI_ADDR=127.0.0.10
fi
if [ -z "$NSI_PORT" ]; then
    NSI_PORT=7777
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
if [ -z "$NRF_ADDR" ]; then
    NRF_ADDR=127.0.0.10
fi
if [ -z "$NRF_PORT" ]; then
    NRF_PORT=7777
fi
printf "logger:
    file: /var/log/open5gs/nssf.log

nssf:
    sbi:
      - addr: $NSSF_ADDR
        port: $NSSF_PORT
    nsi:
      - addr: $NSI_ADDR
        port: $NSI_PORT
        s_nssai:
          sst: 1

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
/bin/open5gs-nssfd
