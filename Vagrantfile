# -*- mode: ruby -*-
# vi: set ft=ruby :

cluster = {
  "registry" => { :hostname => "registry.cluster.local", :ip => "192.168.73.4", :cpus => 1, :mem => 1024 },
  "sandbox-1" => { :hostname => "sandbox-1.cluster.local", :ip => "192.168.73.10", :cpus => 1, :mem => 4096 },
  "sandbox-2" => { :hostname => "sandbox-2.cluster.local", :ip => "192.168.73.14", :cpus => 1, :mem => 2048 },
  "sandbox-3" => { :hostname => "sandbox-3.cluster.local", :ip => "192.168.73.24", :cpus => 1, :mem => 2048 },
  "sandbox-4" => { :hostname => "sandbox-4.cluster.local", :ip => "192.168.73.34", :cpus => 1, :mem => 2048 }
}

Vagrant.configure("2") do |config|

  cluster.each_with_index do |(name, info), index|

    config.vm.define name do |cfg|
        config.vm.box = "centos/7"
        cfg.vm.hostname = "#{info[:hostname]}"
        cfg.vm.network "private_network", ip: "#{info[:ip]}"
        cfg.vm.provider "virtualbox" do |vb|
            vb.cpus = "#{info[:cpus]}"
            vb.memory = "#{info[:mem]}"
            vb.name = name

            vb.customize ["storagectl", :id, "--name", "SATA Controller", "--add", "sata" ]

            (1..3).each do |disk|
                file_to_disk = "./.vagrant/pv-disk/#{name}-disk-#{disk}.vdi"
                unless File.exist?(file_to_disk)
                  vb.customize ['createhd', '--filename', file_to_disk, '--size', 40 * 1024]
                end
                vb.customize ['storageattach', :id, '--storagectl', "SATA Controller", '--port', "#{disk-1}", '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
            end

        end
    end # end config
	config.vm.provision "shell", inline: <<-SHELL
        sudo echo fletcher | passwd root --stdin
        setenforce 0
        sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
        systemctl stop firewalld
        systemctl disable firewalld
        # yum update -y
        # yum install bash-completion net-tools vim -y
	SHELL
  end # end cluster
end