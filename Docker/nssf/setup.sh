#!/bin/sh
CONFIG=/etc/open5gs/nssf.yaml
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
if [ -n "$LOG_ADDR" ] && [ -n "$LOG_PORT" ]; then
if [ -z "$USE_UDP" ]; then
    PROTOCOL="@@"
else
    PROTOCOL="@"
fi
printf "\$ModLoad imfile
\$InputFileName /var/log/open5gs/nssf.log
\$InputFileTag open5gs-nssf
\$InputFileStateFile stat-nssf
\$InputFileSeverity info
\$InputFileFacility local3
\$InputRunFileMonitor
local3.* $PROTOCOL$LOG_ADDR:$LOG_PORT;RSYSLOG_SyslogProtocol23Format" > /etc/rsyslog.d/00-logger.conf
sed -i "s/^module(load=\"imklog\"/#module(load=\"imklog\"/" /etc/rsyslog.conf
/usr/sbin/rsyslogd &
fi
/bin/open5gs-nssfd
