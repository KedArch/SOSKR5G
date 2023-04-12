#!/usr/bin/env bash
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/kubernetes.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/kubernetes.gpg] http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install kubeadm kubelet kubectl docker.io -y
sudo apt-mark hold kubeadm kubelet kubectl
sudo systemctl stop kubelet containerd docker
sudo swapoff -a
sudo sed -i "s/ swap / s/^\(.*\)$/#\1/g" /etc/fstab
printf "overlay\nbr_netfilter\n" | sudo tee /etc/modules-load.d/containerd.conf
sudo modprobe overlay
sudo modprobe br_netfilter
printf "net.bridge.bridge-nf-call-ip6tables = 1\nnet.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1\n" | sudo tee /etc/sysctl.d/kubernetes.conf
sudo sysctl --system
sudo mkdir -p /etc/containerd/certs.d/192.168.39.1
printf "server = \"http://192.168.39.1\"\n\n[host.\"http://192.168.39.1:5000\"]\n  capabilities = [\"pull\", \"resolve\", \"push\"]\n  skip_verify = true" | sudo tee /etc/containerd/certs.d/192.168.39.1/hosts.toml
sudo systemctl disable --now ufw
sudo systemctl enable --now kubelet containerd docker
sudo kubeadm config images pull
