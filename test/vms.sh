#!/usr/bin/bash
if [ "$1" == "create" ]; then
	./create_vm.sh master-1 108 10G
	./create_vm.sh master-2 109 10G
	./create_vm.sh master-3 110 10G
	./create_vm.sh worker-1 111 15G
	./create_vm.sh worker-2 112 15G
elif [ "$1" == "delete" ]; then
	./delete_vm.sh master-1
	./delete_vm.sh master-2
	./delete_vm.sh master-3
	./delete_vm.sh worker-1
	./delete_vm.sh worker-2
else
	echo "Invalid option, allowed 'create' or 'delete'"
fi
