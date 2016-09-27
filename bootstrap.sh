#!/bin/bash

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

function setup_kubernetes_master() {
	echo "Configuring Kubernetes Master..."
	sudo kubeadm init
	echo "Make a record of the kubeadm join command that kubeadm init outputs. You will need this in a moment."
	echo "The key included here is secret, keep it safe!"
	echo "Anyone with this key can add authenticated nodes to your cluster!"

}

function setup_kubernetes_node() {
	echo "To configure a Kubernetes Node..."
	echo "$ vagrant ssh node"
	echo "$ sudo su -"
	echo "# kubeadm join --token <token> <master-ip>"
}


disable_apt_interactive_mode
setup_apt_repos
update_upgrade_autoremove
install_apt_deps

if [[ "$@" == "master" ]]; then
	setup_kubernetes_master
else
	setup_kubernetes_node
fi
