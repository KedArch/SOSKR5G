#!/usr/bin/env bash
set -euo pipefail
export IFS=""
export WORKDIR=$(realpath $(dirname $0))
export NAME=$1
export IPE=$2
if [ -z $NAME ]; then
    printf "1 argument Name is empty!\n"
    exit 1
fi
if [ -z $IPE ]; then
    printf "2 argument IPE (fourth IP address octet value for internal interface) is empty!\n"
    exit 1
fi
if [ -n "$(virsh list --all | grep $NAME)" ]; then
    printf "VM named $NAME already exist\n"
    exit 2
fi 
cd /var/lib/libvirt/images
if ! [ -f focal-server-cloudimg-amd64.img ]; then
    wget http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
fi
qemu-img create -b focal-server-cloudimg-amd64.img -f qcow2 -F qcow2 $NAME.img 10G
cd $WORKDIR
printf "instance-id: $NAME
local-hostname: $NAME\n" > meta-data
export PUBKEYS=
while read -r line; do
    PUBKEYS="\n     - $line$PUBKEYS"
done < pubkeys
printf "#cloud-config

users:
  - name: user
    groups: wheel
    shell: /bin/bash
    sudo: [\"ALL=(ALL) NOPASSWD:ALL\"]
    passwd: \$6\$TXiDTESDLfeBBjry\$ls7ZisnCBEk6BnOJIOMcYowCBO4DNs9E4F0pQwqjDftk6ne8i/wfswsGdIOCn60lgohvjHKihtvffNjWOKL691 #zaq
    lock_passwd: false
    ssh_authorized_keys:$PUBKEYS\n" > user-data
printf "version: 2
ethernets:
    enp0s2:
        dhcp4: true
        dhcp6: true
    enp0s3:
      addresses: [192.168.39.$IPE/24]
      dhcp6: false
      dhcp4: false\n" > network-config
genisoimage -output cidata-$NAME.iso -V cidata -r -J user-data meta-data network-config
mkdir -p vm-conf
mv meta-data vm-conf/meta-data-$NAME
mv user-data vm-conf/user-data-$NAME
mv network-config vm-conf/network-config-$NAME
mv cidata-$NAME.iso /var/lib/libvirt/images
cp vm.xml vm-conf/vm-$NAME.xml
sed -i "s/vm-name/$NAME/g" vm-conf/vm-$NAME.xml
virsh define vm-conf/vm-$NAME.xml
virsh autostart $NAME
virsh start $NAME
