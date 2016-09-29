#!/bin/bash

NODE_TYPE=$1
TOKEN=$2
MASTER_IP=$3
LOCAL_IP=$4


function disable_apt_interactive_mode() {
	echo "Disabling APT interactive mode..."
	sudo mv -v /etc/apt/apt.conf.d/70debconf /root/etc-apt-apt.conf.d-70debconf.bak
	sudo dpkg-reconfigure debconf -f noninteractive -p critical
}

function setup_apt_repos() {
	echo "Setting up APT repositories for dependencies..."
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
	echo deb http://apt.kubernetes.io/ kubernetes-xenial main | sudo tee /etc/apt/sources.list.d/kubernetes.list
}

function update_upgrade_autoremove() {
	echo "Updating and Upgrading system..."
	sudo apt-get update
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
	sudo apt-get -y autoremove
}

function install_apt_deps() {
	echo "Installing dependencies..."
	sudo apt-get -y install docker.io kubelet kubeadm kubectl kubernetes-cni
}

function setup_kubelet_interface() {
	sudo printf '[Service]\nEnvironment="KUBELET_EXTRA_ARGS=--hostname-override=%s"\n' $LOCAL_IP | \
		sudo tee /etc/systemd/system/kubelet.service.d/09-hostname-override.conf
}

function setup_kubernetes_master() {
	echo "Configuring Kubernetes Master..."
	sudo kubeadm init --token $TOKEN --api-advertise-addresses=$MASTER_IP
	sudo kubectl apply -f https://git.io/weave-kube
#	sudo kubectl create -f https://rawgit.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml
	sudo kubectl config view
	sudo kubectl get pods --all-namespaces
}

function setup_kubernetes_node() {
	echo "Configuring a Kubernetes Node..."
	echo "sudo kubeadm join --token $TOKEN $MASTER_IP"
	sudo kubeadm join --token $TOKEN $MASTER_IP
}

disable_apt_interactive_mode
setup_apt_repos
update_upgrade_autoremove
install_apt_deps
setup_kubelet_interface

if [[ "$NODE_TYPE" == "master" ]]; then
	setup_kubernetes_master
else
	setup_kubernetes_node
fi
