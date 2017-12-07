Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  config.vm.box = "bento/ubuntu-17.04"
  config.vm.provision :shell, :path => "init.sh", privileged: false
  config.vm.network "private_network", ip: "192.168.255.233"
end

