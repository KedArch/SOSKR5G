# Testing environment
These are files for testing environment of this project
# On host
To make sure that every VM will have access to images without pushing them to DockerHub I settled on creating own repository:\
`docker run -d -p 5000:5000 -e REGISTRY_AUTH=none --restart=always --name registry registry:2`\
which will require host to configure docker daemon at /etc/docker/daemon.json to add this:
```json
{
  "insecure-registries": ["192.168.39.1:5000"]
}
```
# Files
## create_vm.sh
Creates VM with name as first parameter and sets IP 192.168.39.X, where X is second parameter
## delete_vm.sh
Deletes VM with name as first parameter
## install_kubespray.sh
Clones and prepares kubespray for cluster installation
## net.sh
Installs internal network for node communication
## net.xml
Internal network definition (192.168.39.0/24)
## vm.xml
VM template
## vms.sh
Creates or deletes VMs needed for testing purpose (basic installation and config for K8s, cluster not set)
