# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.cpus = 1
    vb.memory = 1024
  end

  # Master
  config.vm.define 'kubemaster', autostart: true do |host|
    host.vm.hostname = 'kubemaster'
    host.vm.network 'private_network', ip: '172.16.0.10'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: 'master'
  end

  # Nodes
  
  config.vm.define 'kubenode01', autostart: true do |host|
    host.vm.hostname = 'kubenode01'
    host.vm.network 'private_network', ip: '172.16.0.21'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: 'node'
  end

  config.vm.define 'kubenode02', autostart: true do |host|
    host.vm.hostname = 'kubenode02'
    host.vm.network 'private_network', ip: '172.16.0.22'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: 'node'
  end

  config.vm.define 'kubenode03', autostart: true do |host|
    host.vm.hostname = 'kubenode03'
    host.vm.network 'private_network', ip: '172.16.0.23'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: 'node'
  end

end
