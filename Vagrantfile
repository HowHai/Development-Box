# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'precise32'
  config.vm.box_url  = 'http://files.vagrantup.com/precise32.box'
  config.vm.hostname = 'rails-dev-box'

  config.vm.provider 'vmware_fusion' do |v, override|
    override.vm.box     = 'precise64'
    override.vm.box_url = 'http://files.vagrantup.com/precise64_vmware.box'
  end

  config.vm.provider 'parallels' do |v, override|
    override.vm.box = 'parallels/ubuntu-12.04'
    override.vm.box_url = 'https://vagrantcloud.com/parallels/ubuntu-12.04'

    # Can be running at background, see https://github.com/Parallels/vagrant-parallels/issues/39
    v.customize ['set', :id, '--on-window-close', 'keep-running']
  end

  # Rails port
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  # Angular port
  config.vm.network :forwarded_port, guest: 4001, host: 4001
  # Ionic ports http / livereload
  config.vm.network :forwarded_port, guest: 5000, host: 5000
  config.vm.network :forwarded_port, guest: 5001, host: 5001
  # Laravel ports
  config.vm.network :forwarded_port, guest: 8000, host: 8000
 

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path    = 'puppet/modules'
  end
end
