# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "laravel/homestead"
  config.vm.box_version = "0.3.3"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 3306, host: 33060
  config.vm.network "forwarded_port", guest: 6379, host: 63790

  # Create a private network, which allows host-only access to the machine
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end
  config.vm.provision :shell do |s|
    s.inline = <<-SHELL
      sudo cp /vagrant/.provision/confoo-php.io /etc/nginx/sites-available/confoo-php.io
      sudo ln -fs "/etc/nginx/sites-available/confoo-php.io" "/etc/nginx/sites-enabled/confoo-php.io"
      sudo cp --force /vagrant/.provision/cache.cnf /etc/mysql/conf.d/cache.cnf
    SHELL
  end

  config.vm.provision :shell, inline: <<-SHELL
    mysql -uhomestead -psecret --host 127.0.0.1 < /vagrant/.provision/mysql_setup.sql
  SHELL

  config.vm.provision :shell, inline: <<-SHELL
    # Newrelic
    echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | sudo tee /etc/apt/sources.list.d/newrelic.list
    wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
    wget -O- http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

    if ! grep -qe "http://nginx.org/packages/ubuntu/" "/etc/apt/sources.list"; then
        echo "# Nginx packages" >> /etc/apt/sources.list
        echo "deb http://nginx.org/packages/ubuntu/ trusty nginx\ndeb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
    fi

    echo newrelic-php5 newrelic-php5/application-name string "Confoo PHP" | debconf-set-selections
    echo newrelic-php5 newrelic-php5/license-key string "324bec1441076c34c37333a0568f85039514de65"
    sudo apt-get update
    sudo apt-get install -y newrelic-php5
    sudo newrelic-install install
    sudo rm /etc/php5/fpm/conf.d/newrelic.ini

    sudo apt-get install -y nginx-nr-agent
    sudo sed -i "s/YOUR_LICENSE_KEY_HERE/324bec1441076c34c37333a0568f85039514de65/" /etc/nginx-nr-agent/nginx-nr-agent.ini
    if ! grep -qe "confoo-php.io" "/etc/nginx-nr-agent/nginx-nr-agent.ini"; then
        echo "[source1]\nname=Confoo PHP\nurl=http://localhost/status" >> /etc/nginx-nr-agent/nginx-nr-agent.ini
        echo "# Nginx packages" >> /etc/apt/sources.list
    fi
    if ! grep -qe "http://nginx.org/packages/ubuntu/" "/etc/apt/sources.list"; then
        echo "deb http://nginx.org/packages/ubuntu/ trusty nginx\ndeb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
    fi

    # if ! grep -qe "confoo-php.io" "/etc/hosts"; then
    #     echo "127.0.0.1 confoo-php.io" >> /etc/hosts
    # fi

    # Toxiproxy
    wget -O toxiproxy-1.2.1.deb https://github.com/Shopify/toxiproxy/releases/download/v1.2.1/toxiproxy_1.2.1_amd64.deb 2> /dev/null
    sudo dpkg -i toxiproxy-1.2.1.deb


    sudo service toxiproxy restart
    sudo service nginx restart
    sudo service php5-fpm restart
    sudo service nginx-nr-agent restart
  SHELL
end
