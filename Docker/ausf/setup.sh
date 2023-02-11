#!/bin/sh
CONFIG=/etc/open5gs/ausf.yml
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
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "logger:
    file: @localstatedir@/log/open5gs/ausf.log

tls:
    enabled: no
    server:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/ausf.key
      cert: @sysconfdir@/open5gs/tls/ausf.crt
    client:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/ausf.key
      cert: @sysconfdir@/open5gs/tls/ausf.crt

ausf:
    sbi:
      - addr: $AUSF_ADDR
        port: $AUSF_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT


parameter:

max:

time:
" > $CONFIG
/bin/open5gs-ausfd
