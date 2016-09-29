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
    role = 'master'
    local_ip = master_ip
    host.vm.hostname = 'kmaster01'
    host.vm.network 'private_network', ip: local_ip
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "#{role} #{token} #{master_ip} #{local_ip}"
  end

  # Nodes
  
  config.vm.define 'knode01', autostart: true do |host|
    role = 'node'
    local_ip = '172.16.0.21'
    host.vm.hostname = 'knode01'
    host.vm.network 'private_network', ip: local_ip
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "#{role} #{token} #{master_ip} #{local_ip}"
  end

  config.vm.define 'knode02', autostart: true do |host|
    role = 'node'
    local_ip = '172.16.0.22'
    host.vm.hostname = 'knode02'
    host.vm.network 'private_network', ip: local_ip
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "#{role} #{token} #{master_ip} #{local_ip}"
  end

  config.vm.define 'knode03', autostart: true do |host|
    role = 'node'
    local_ip = '172.16.0.23'
    host.vm.hostname = 'knode03'
    host.vm.network 'private_network', ip: local_ip
    host.vm.provision 'shell', path: 'bootstrap.sh', args: "#{role} #{token} #{master_ip} #{local_ip}"
  end

end
