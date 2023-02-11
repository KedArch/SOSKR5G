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
    file: @localstatedir@/log/open5gs/udm.log

tls:
    enabled: no
    server:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/udm.key
      cert: @sysconfdir@/open5gs/tls/udm.crt
    client:
      cacert: @sysconfdir@/open5gs/tls/ca.crt
      key: @sysconfdir@/open5gs/tls/udm.key
      cert: @sysconfdir@/open5gs/tls/udm.crt

hnet:
  - id: 1
    scheme: 1
    key: @sysconfdir@/open5gs/hnet/curve25519-1.key
  - id: 2
    scheme: 2
    key: @sysconfdir@/open5gs/hnet/secp256r1-2.key
  - id: 3
    scheme: 1
    key: @sysconfdir@/open5gs/hnet/curve25519-3.key
  - id: 4
    scheme: 2
    key: @sysconfdir@/open5gs/hnet/secp256r1-4.key
  - id: 5
    scheme: 1
    key: @sysconfdir@/open5gs/hnet/curve25519-5.key
  - id: 6
    scheme: 2
    key: @sysconfdir@/open5gs/hnet/secp256r1-6.key

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
