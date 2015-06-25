# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "puppetlabs/centos-6.6-64-puppet"

  # Configure additional CPUs and Memory
#  config.vm.provider "virtualbox" do |v|
#      v.memory = 2048
#      v.cpus = 2
#  end

  config.vm.define "es-00" do |v|
    v.vm.network "private_network", type: "dhcp"
    v.vm.hostname = "es-00"
  end

  config.vm.define "es-01" do |v|
    v.vm.network "private_network", type: "dhcp"
    v.vm.hostname = "es-01"
  end

  #
  # Add the required puppet modules before provisioning is run by puppet
  #
  config.vm.provision :shell do |shell|
     shell.inline = "puppet module install puppetlabs/java;
                     puppet module install camptocamp-augeas;
                     puppet module install elasticsearch-elasticsearch;
                     puppet module install boundary-boundary;
                     exit 0"
  end

  #
  # Use Puppet to provision the server and setup an elastic search cluster
  # on a single box
  #
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end


end
