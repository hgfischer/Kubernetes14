# -*- mode: ruby -*-
# vi: set ft=ruby :


master_ip = '172.16.0.11'
token = 'uCop6h.eequaiz5reeLeiDi'


Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.cpus = 1
    vb.memory = 1024
  end

  # Master
  
  config.vm.define 'kmaster01', autostart: true do |host|
    host.vm.hostname = 'kmaster01'
    host.vm.network 'private_network', ip: master_ip
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "master #{master_ip} #{token}"
  end

  # Nodes
  
  config.vm.define 'knode01', autostart: true do |host|
    host.vm.hostname = 'knode01'
    host.vm.network 'private_network', ip: '172.16.0.21'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "node #{master_ip} #{token}"
  end

  config.vm.define 'knode02', autostart: true do |host|
    host.vm.hostname = 'knode02'
    host.vm.network 'private_network', ip: '172.16.0.22'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "node #{master_ip} #{token}"
  end

  config.vm.define 'knode03', autostart: true do |host|
    host.vm.hostname = 'knode03'
    host.vm.network 'private_network', ip: '172.16.0.23'
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "node #{master_ip} #{token}"
  end

end
