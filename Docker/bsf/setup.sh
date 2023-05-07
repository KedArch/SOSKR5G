#!/bin/sh
CONFIG=/etc/open5gs/bsf.yaml
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
if [ -z "$NRF_ADDR" ]; then
    NRF_ADDR=127.0.0.10
fi
if [ -z "$NRF_PORT" ]; then
    NRF_PORT=7777
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
\$InputFileName /var/log/open5gs/bsf.log
\$InputFileTag open5gs-bsf
\$InputFileStateFile stat-bsf
\$InputFileSeverity info
\$InputFileFacility local3
\$InputRunFileMonitor
local3.* $PROTOCOL$LOG_ADDR:$LOG_PORT;RSYSLOG_SyslogProtocol23Format" > /etc/rsyslog.d/00-logger.conf
sed -i "s/^module(load=\"imklog\"/#module(load=\"imklog\"/" /etc/rsyslog.conf
/usr/sbin/rsyslogd &
fi
/bin/open5gs-bsfd
