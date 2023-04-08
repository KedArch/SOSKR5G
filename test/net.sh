#!/usr/bin/env bash
virsh net-destroy internal
virsh net-undefine internal
virsh net-define net.xml
virsh net-autostart internal
virsh net-start internal
