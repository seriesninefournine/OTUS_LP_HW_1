# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = "1024"
    v.cpus = 2
    v.name = "OTUS-LP-01-test"
    v.gui = false
  end
  config.vm.box = "series949/centos-5-4-137"
  config.vm.box_check_update = false
  config.vm.define "node_01" do |node_01|
    node_01.vm.hostname = "OTUS-LP-01"
#    node_01.vm.network "private_network", ip: "192.168.50.4"
    node_01.vm.synced_folder "./node_01_sync", "/home/vagrant/node_01_sync", SharedFoldersEnableSymlinksCreate: false
    node_01.vm.provision "shell", inline: <<-SHELL
      yum update -y
      sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/#g' /etc/ssh/sshd_config
      systemctl restart sshd
    SHELL
  end
end
