#!/usr/bin/env ruby

# Default Vagrant Box
BOX = ENV['VAGRANT_BOX'] || 'dhoppe/debian-8.2.0-amd64-nocm'

# -*- mode: ruby -*-
Vagrant.configure(2) do |config|
  config.vm.box = BOX
  config.vm.provision "shell",
    inline: "/bin/sh /vagrant/script/bootstrap-vagrant"


  ### ADD USER DATA HERE ###

end
