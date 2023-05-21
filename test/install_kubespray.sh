#!/usr/bin/env bash
cd $(dirname $(realpath $0))
cd ../..
git clone git@github.com:KedArch/SOSKR5G-kubespray.git
VENVDIR=kubespray-venv
KUBESPRAYDIR=SOSKR5G-kubespray
ANSIBLE_VERSION=2.12
python3 -m venv $VENVDIR
source $VENVDIR/bin/activate
cd $KUBESPRAYDIR
pip install -U -r requirements-$ANSIBLE_VERSION.txt
#ansible-playbook -i inventory/5gcore/hosts.yaml cluster.yml -b -v --private-key=~/.ssh/id_rsa -u user
