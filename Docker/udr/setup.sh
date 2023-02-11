#!/bin/sh
CONFIG=/etc/open5gs/udr.yml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$DB_URI" ]; then
    DB_URI=mongodb://localhost/open5gs
fi
if [ -z "$UDR_ADDR" ]; then
    UDR_ADDR=127.0.0.20
fi
if [ -z "$UDR_PORT" ]; then
    UDR_PORT=7777
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "db_uri: $DB_URI

logger:
    file: @localstatedir@/log/open5gs/udr.log

tls:
    enabled: no
    server:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/udr.key
      cert: @sysconfdir@/open5gs/tls/udr.crt
    client:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/udr.key
      cert: @sysconfdir@/open5gs/tls/udr.crt

udr:
    sbi:
      - addr: $UDR_ADDR
        port: $UDR_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT


parameter:

max:

time:
" > $CONFIG
/bin/open5gs-udrd

