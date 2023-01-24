#!/bin/sh
if [ -n "$DB_URI" ]; then
    sed -i "s/^db_uri: .*/db_uri: $DB_URI" /etc/open5gs/pcf.yaml
fi
if [ -n "$SBI_ADDR" ]; then
    sed -z -i "s/\(pcf:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SBI_ADDR/" /etc/open5gs/pcf.yaml
fi
if [ -n "$METRICS_ADDR" ]; then
    sed -z -i "s/\(pcf:\n[^#]*metrics:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $METRICS_ADDR/" /etc/open5gs/pcf.yaml
fi
if [ -n "$SCP_ADDR" ]; then
    sed -z -i "s/\(scp:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SCP_ADDR/" /etc/open5gs/pcf.yaml
fi
/bin/open5gs-pcfd
