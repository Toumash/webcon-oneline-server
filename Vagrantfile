# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-'SCRIPT'
echo "These are my \"quotes\"! I am provisioning my guest."
date > C:\\vm-provisioned-at.txt
SCRIPT
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Box list: https://github.com/gusztavvargadr/workstations

  # uncomment this line if you want to develop again server with separate SQL installation
  # config.vm.box = "gusztavvargadr/windows-server"
  # For integrated standalone one-vm setup
  config.vm.box = "gusztavvargadr/sql-server"

  config.vm.define "webcon-web"
  config.vm.hostname = "webcon-web"

  # DONT DO THE FOLLOWING! The best way to copy files on windows is SAMBA, use additionally S3/FTP/HTTP if needed
  # config.vm.provision "file", source: "WebconBPS.zip", destination: "WebconBPS.zip"

  config.vm.synced_folder ".", "/vagrant", type: "smb", mount_options: ["domain=" + ENV["USERDOMAIN"]]

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "source/playbook.yml"
  end
  # Chocolately is already installed on the box
  # config.vm.provision "shell", path: "source/InstallChocolately.ps1"
  config.vm.provision "shell", path: "source/InstallWebcon.ps1"

  # config.vm.provision "shell", inline: $script

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network :private_network, ip: "192.168.58.111"

  config.vm.provider :hyperv do |h|

    # Don't boot with headless mode
    #   vb.gui = true
    h.memory = 1024
    h.cpus = 4
    h.vm_integration_services = {
      guest_service_interface: true,
    }
    h.enable_virtualization_extensions = true
    h.linked_clone = true

    h.enable_enhanced_session_mode = true
  end

  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file centos65.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
