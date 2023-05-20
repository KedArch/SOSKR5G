#!/usr/bin/env bash
set -euo pipefail
export WORKDIR=$(realpath $(dirname $0))
if [ -z $1 ]; then
    printf "1 argument Name is empty!\n"
    exit 1
fi
if [ -z $2 ]; then
    printf "2 argument (fourth IP address octet value for internal interface) is empty!\n"
    exit 1
fi
if [ -n "$(virsh list --all | grep $1)" ]; then
    printf "VM named $1 already exist\n"
    exit 2
fi 
cd /var/lib/libvirt/images
if ! [ -f focal-server-cloudimg-amd64.img ]; then
    wget http://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
fi
qemu-img create -b focal-server-cloudimg-amd64.img -f qcow2 -F qcow2 $1.img 10G
cd $WORKDIR
printf "instance-id: $1
local-hostname: $1\n" > meta-data
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
      addresses: [192.168.39.$2/24 fc00::$2/120]
      dhcp6: false
      dhcp4: false\n" > network-config
genisoimage -output cidata-$1.iso -V cidata -r -J user-data meta-data network-config
mkdir -p vm-conf
mv meta-data vm-conf/meta-data-$1
mv user-data vm-conf/user-data-$1
mv network-config vm-conf/network-config-$1
mv cidata-$1.iso /var/lib/libvirt/images
cp vm.xml vm-conf/vm-$1.xml
sed -i "s/vm-name/$1/g" vm-conf/vm-$1.xml
virsh define vm-conf/vm-$1.xml
virsh autostart $1
virsh start $1
