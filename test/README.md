# Testing environment
There are files for testing environment of this project
# Todo
Create K8s cluster
# Files
## net.xml
Internal network definition (192.168.39.0/24)
## vm.xml
VM template
## create_vm.sh
Creates VM with name as first parameter and sets IP 192.168.39.X, where X is second parameter
## delete_vm.sh
Deletes VM with name as first parameter
## vms.sh
Creates or deletes VMs needed for testing purpose (basic config)
