#!/bin/sh
CONFIG=/etc/open5gs/scp.yml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
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
printf "db_uri: mongodb://localhost/open5gs

logger:
    file: @localstatedir@/log/open5gs/scp.log

tls:
    enabled: no
    server:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/scp.key
      cert: @sysconfdir@/open5gs/tls/scp.crt
    client:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/scp.key
      cert: @sysconfdir@/open5gs/tls/scp.crt

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