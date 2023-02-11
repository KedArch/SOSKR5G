#!/bin/sh
CONFIG=/etc/open5gs/scp.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$DB_URI" ]; then
    DB_URI=mongodb://localhost/open5gs
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
if [ -z "$NRF_ADDR" ]; then
    NRF_ADDR="127.0.0.10 ::1"
fi
NRF_ADDR=`echo $NRF_ADDR | sed 's/ /\n          - /g'`
if [ -z "$NRF_PORT" ]; then
    NRF_PORT=7777
fi
printf "db_uri: $DB_URI

logger:
    file: /var/log/open5gs/scp.log

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT


nrf:
    sbi:
      - addr:
          - $NRF_ADDR
        port: $NRF_PORT

parameter:

max:

time:
" > $CONFIG
/bin/open5gs-scpd