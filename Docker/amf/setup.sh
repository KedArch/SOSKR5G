#!/bin/sh
CONFIG=/etc/open5gs/amf.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$AMF_ADDR" ]; then
    AMF_ADDR=127.0.0.5
fi
if [ -z "$AMF_PORT" ]; then
    AMF_PORT=7777
fi
if [ -z "$NGAP_ADDR" ]; then
    NGAP_ADDR=127.0.0.5
fi
if [ -z "$METRICS_ADDR" ]; then
    METRICS_ADDR=127.0.0.5
fi
if [ -z "$METRICS_PORT" ]; then
    METRICS_PORT=9090
fi
if [ -z "$MCC" ]; then
    MCC=999
fi
if [ -z "$MNC" ]; then
    MNC=70
fi
if [ -z "$REGION" ]; then
    REGION=2
fi
if [ -z "$SET" ]; then
    SET=1
fi
if [ -z "$NETWORK_NAME" ]; then
    NETWORK_NAME=Open5GS
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
POINTER=`echo $HOSTNAME`
printf "logger:
    file: /var/log/open5gs/amf.log

amf:
    sbi:
      - addr: $AMF_ADDR
        port: $AMF_PORT
    ngap:
      - addr: $NGAP_ADDR
    metrics:
      - addr: $METRICS_ADDR
        port: $METRICS_PORT
    guami:
      - plmn_id:
          mcc: $MCC
          mnc: $MNC
        amf_id:
          region: $REGION
          set: $SET
          pointer: $POINTER
    tai:
      - plmn_id:
          mcc: $MCC
          mnc: $MNC
        tac: 1
    plmn_support:
      - plmn_id:
          mcc: $MCC
          mnc: $MNC
        s_nssai:
          - sst: 1
    security:
        integrity_order : [ NIA2, NIA1, NIA0 ]
        ciphering_order : [ NEA0, NEA1, NEA2 ]
    network_name:
        full: $NETWORK_NAME
    amf_name: $HOSTNAME

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

usrsctp:

time:
" > $CONFIG
/bin/open5gs-amfd
