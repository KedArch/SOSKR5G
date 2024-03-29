#!/bin/sh
CONFIG=/etc/open5gs/smf.yaml
if [ -z "$SMF_ADDR" ]; then
    SMF_ADDR=127.0.0.4
fi
if [ -z "$SMF_PORT" ]; then
    SMF_PORT=7777
fi
if [ -z "$PFCP_ADDR" ]; then
    PFCP_ADDR="127.0.0.4 ::1"
fi
PFCP_ADDR=`echo $PFCP_ADDR | sed 's/ /\n      - addr: /g'`
if [ -z "$GTPC_ADDR" ]; then
    GTPC_ADDR="127.0.0.4 ::1"
fi
GTPC_ADDR=`echo $GTPC_ADDR | sed 's/ /\n      - addr: /g'`
if [ -z "$GTPU_ADDR" ]; then
    GTPU_ADDR="127.0.0.4 ::1"
fi
GTPU_ADDR=`echo $GTPU_ADDR | sed 's/ /\n      - addr: /g'`
if [ -z "$METRICS_ADDR" ]; then
    METRICS_ADDR=127.0.0.4
fi
if [ -z "$METRICS_PORT" ]; then
    METRICS_PORT=9090
fi
if [ -z "$SUBNET_ADDR" ]; then
    SUBNET_ADDR="10.45.0.1/16 2001:db8:cafe::1/48"
SUBNET_ADDR=`echo $SUBNET_ADDR | sed 's/ /\n      - addr: /g'`
fi
if [ -z "$DNS_ADDR" ]; then
    DNS_ADDR="8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844"
fi
DNS_ADDR=`echo $DNS_ADDR | sed 's/ /\n      - /g'`
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
if [ -z "$UPF_ADDR" ]; then
    UPF_ADDR=127.0.0.7
fi
printf "logger:
    file: /var/log/open5gs/smf.log

smf:
    sbi:
      - addr: $SMF_ADDR
        port: $SMF_PORT
    pfcp:
      - addr: $PFCP_ADDR
    gtpc:
      - addr: $GTPC_ADDR
    gtpu:
      - addr: $GTPU_ADDR
    metrics:
      - addr: $METRICS_ADDR
        port: $METRICS_PORT
    subnet:
      - addr: $SUBNET_ADDR
    dns:
      - $DNS_ADDR

scp:
    sbi:
      - addr: $SCP_ADDR
        port: $SCP_PORT

nrf:
    sbi:
      - addr: $NRF_ADDR
        port: $NRF_PORT

upf:
    pfcp:
      - addr: $UPF_ADDR

parameter:

max:

time:
" > $CONFIG
if [ -n "$LOG_ADDR" ] && [ -n "$LOG_PORT" ]; then
if [ -z "$USE_UDP" ]; then
    PROTOCOL="@@"
else
    PROTOCOL="@"
fi
printf "\$ModLoad imfile
\$InputFileName /var/log/open5gs/smf.log
\$InputFileTag open5gs-smf
\$InputFileStateFile stat-smf
\$InputFileSeverity info
\$InputFileFacility local3
\$InputRunFileMonitor
local3.* $PROTOCOL$LOG_ADDR:$LOG_PORT;RSYSLOG_SyslogProtocol23Format" > /etc/rsyslog.d/00-logger.conf
sed -i "s/^module(load=\"imklog\"/#module(load=\"imklog\"/" /etc/rsyslog.conf
/usr/sbin/rsyslogd &
fi
/bin/open5gs-smfd
