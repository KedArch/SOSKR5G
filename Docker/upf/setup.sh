#!/bin/sh
CONFIG=/etc/open5gs/upf.yaml
if ! [ -f "$CONFIG-original" ]; then
    mv $CONFIG $CONFIG-original
fi
if [ -z "$PFCP_ADDR" ]; then
    PFCP_ADDR=127.0.0.7
fi
if [ -z "$GTPU_ADDR" ]; then
    GTPU_ADDR=127.0.0.7
fi
if [ -z "$SUBNET_ADDR" ]; then
    SUBNET_ADDR="10.45.0.1/16 2001:db8:cafe::1/48"
fi
# Create /dev/net/tun - requires NET_ADMIN capabilities
mkdir /dev/net
mknod /dev/net/tun c 10 200
# Modified version of setup script from open5gs repository
if ! grep "ogstun" /proc/net/dev > /dev/null; then
    ip tuntap add name ogstun mode tun
fi
for I in $SUBNET_ADDR; do
    ip addr del $I dev ogstun 2> /dev/null
    ip addr add $I dev ogstun
done
ip link set ogstun up
# github.com/open5gs/open5gs - modified
POD_SUBNET=`ip a show eth0 | grep inet | sed 's/ *//' | cut -d' ' -f2`
for I in $SUBNET_ADDR; do
    case "$I" in
        *:*)
            IPTABLES=ip6tables
            ;;
        *)
            IPTABLES=iptables
            ;;
    esac
    $IPTABLES -t nat -A POSTROUTING -s $I ! -o ogstun -j MASQUERADE
    $IPTABLES -I INPUT -s $I -j DROP
    $IPTABLES -I FORWARD -s $I -d $POD_SUBNET -j DROP
done
iptables -I INPUT -i ogstun -j ACCEPT
SUBNET_ADDR=`echo $SUBNET_ADDR | sed 's/ /\n      - addr: /g'`
if [ -z "$METRICS_ADDR" ]; then
    METRICS_ADDR=127.0.0.7
fi
if [ -z "$METRICS_PORT" ]; then
    METRICS_PORT=9090
fi
if [ -z "$SMF_ADDR" ]; then
    SMF_ADDR=127.0.0.4
fi
printf "logger:
    file: /var/log/open5gs/upf.log

upf:
    pfcp:
      - addr: $PFCP_ADDR
    gtpu:
      - addr: $GTPU_ADDR
    subnet:
      - addr: $SUBNET_ADDR
    metrics:
      - addr: $METRICS_ADDR
        port: $METRICS_PORT

smf:
   pfcp:
      addr: $SMF_ADDR

parameter:

max:

time:
" > $CONFIG
/bin/open5gs-upfd
