#!/usr/bin/env bash
export WORKDIR=$(realpath $(dirname $0))
export NAME=$1
if [ -z $NAME ]; then
    printf "Name is empty!"
    exit 1
fi
if [ -z "$(virsh list --all | grep $NAME)" ]; then
    printf "VM named $NAME is undefined, trying to delete its files anyway"
else
    virsh destroy $NAME
    virsh undefine $NAME
fi
cd vm-conf
rm vm-$NAME.xml meta-data-$NAME user-data-$NAME network-config-$NAME
cd /var/lib/libvirt/images
rm cidata-$NAME.iso $NAME.img
