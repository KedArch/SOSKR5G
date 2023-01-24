#!/bin/sh
if [ -n "$SBI_ADDR" ]; then
    sed -z -i "s/\(nssf:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SBI_ADDR/" /etc/open5gs/nssf.yaml
fi
if [ -n "$NSI_ADDR" ]; then
    sed -z -i "s/\(nssf:\n[^#]*nsi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $NSI_ADDR/" /etc/open5gs/nssf.yaml
fi
if [ -n "$SCP_ADDR" ]; then
    sed -z -i "s/\(scp:\n[^#]*sbi:\n *[-]\{0,1\} addr:\) [0-9.]\{1,\}/\1 $SCP_ADDR/" /etc/open5gs/nssf.yaml
fi
/bin/open5gs-nssfd
