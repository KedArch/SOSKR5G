#!/usr/bin/env bash
export WORKDIR=$(realpath $(dirname $0))
if [ -z $1 ]; then
    printf "Name is empty!"
    exit 1
fi
if [ -z "$(virsh list --all | grep $1)" ]; then
    printf "VM named $1 is undefined, trying to delete its files anyway"
else
    virsh destroy $1
    virsh undefine $1
fi
cd vm-conf
rm vm-$1.xml meta-data-$1 user-data-$1 network-config-$1
cd /var/lib/libvirt/images
rm cidata-$1.iso $1.img
