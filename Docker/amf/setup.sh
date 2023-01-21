#!/bin/sh
if [ -n "$SBI_ADDR" ]; then
    sed -z -i "s/\(amf:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SBI_ADDR/" /etc/open5gs/amf.yaml
fi
if [ -n "$NGAP_ADDR" ]; then
    sed -z -i "s/\(amf:\n[^#]*ngap:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $NGAP_ADDR/" /etc/open5gs/amf.yaml
fi
if [ -n "$METRICS_ADDR" ]; then
    sed -z -i "s/\(amf:\n[^#]*metrics:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $METRICS_ADDR/" /etc/open5gs/amf.yaml
fi
if [ -n "$SCP_ADDR" ]; then
    sed -z -i "s/\(scp:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SCP_ADDR/" /etc/open5gs/amf.yaml
fi
if [ -n "$MCC" ]; then
    sed -i "s/mcc: [0-9]\{3\}/mcc: $MCC/" /etc/open5gs/amf.yaml
fi
if [ -n "$MNC" ]; then
    sed -i "s/mnc: [0-9]\{2\}/mnc: $MNC/" /etc/open5gs/amf.yaml
fi
if [ -n "$NETWORK_NAME" ]; then
    sed -i "s/^\([^#].*\)full: .*/\1full: $NETWORK_NAME/" /etc/open5gs/amf.yaml
fi
if [ -n "$NAME" ]; then
    sed -i "s/^\([^#].*\)amf_name: .*/\1amf_name: $NAME/" /etc/open5gs/amf.yaml
fi
/bin/open5gs-amfd
