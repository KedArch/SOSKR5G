#!/bin/sh
if [ -n "$SBI_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SBI_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$PFCP_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*pfcp:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $PFCP_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$GTPC_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*gptc:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $GTPC_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$GTPU_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*gtpu:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $GTPU_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$METRICS_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*metrics:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $METRICS_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$SUBNET_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*subnet:\n *[-]\{0,1\} addr:\) [0-9\/.]\{1,\}/\1 $SUBNET_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$DNS_ADDR" ]; then
    sed -z -i "s/\(smf:\n[^#]*dns:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $DNS_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$SCP_ADDR" ]; then
    sed -z -i "s/\(scp:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SCP_ADDR/" /etc/open5gs/smf.yaml
fi
if [ -n "$UPF_ADDR" ]; then
    sed -z -i "s/\(upf:\n[^#]*pfcp:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $UPF_ADDR/" /etc/open5gs/smf.yaml
fi
/bin/open5gs-smfd
