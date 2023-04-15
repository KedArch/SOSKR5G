#!/usr/bin/env bash
cd $(dirname $(realpath $0))
cd ../..
git clone https://github.com/KedArch/SOSKR5G-kubespray
VENVDIR=kubespray-venv
KUBESPRAYDIR=kubespray
ANSIBLE_VERSION=2.12
~/.local/bin/virtualenv  --python=$(which python3) $VENVDIR
source $VENVDIR/bin/activate
cd $KUBESPRAYDIR
pip install -U -r requirements-$ANSIBLE_VERSION.txt
cp -r SOSKR5G/test/5gcore
#ansible-playbook -i inventory/5gcore/hosts.yaml cluster.yml -b -v --private-key=~/.ssh/id_rsa -u user
