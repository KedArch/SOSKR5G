#!/bin/sh
CONFIG=/etc/open5gs/bsf.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$DB_URI" ]; then
    DB_URI=mongodb://localhost/open5gs
fi
if [ -z "$BSF_ADDR" ]; then
    BSF_ADDR=127.0.0.15
fi
if [ -z "$BSF_PORT" ]; then
    BSF_PORT=7777
fi
if [ -z "$SCP_ADDR" ]; then
    SCP_ADDR=127.0.1.10
fi
if [ -z "$SCP_PORT" ]; then
    SCP_PORT=7777
fi
printf "db_uri: $DB_URI

logger:
    file: /var/log/open5gs/bsf.log

bsf:
    sbi:
      - addr: $BSF_ADDR
        port: $BSF_PORT

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT


parameter:

max:

time:
" > $CONFIG
/bin/open5gs-bsfd
