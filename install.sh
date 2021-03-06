#!/bin/bash
# Author: Hai Nguyen

# Get install option
install_option=$1

# Ask user for install input if none give.
if [[ -z "$1" ]]; then
  echo "Available options: ionic, angular, rails, laravel"
  printf "Please enter install option: "
  read install_option
fi

# Install rails
function install_rails(){
  vagrant up
}

# Install ionic
function install_ionic(){
  vagrant up

  # Hack for installing screen; Need to find better solution.
  vagrant ssh -c "sudo apt-get install screen"

  # Reinstall new version of npm
  vagrant ssh -c "sudo apt-get purge nodejs npm"
  vagrant ssh -c "sudo apt-get update"
  vagrant ssh -c "sudo apt-get install -y python-software-properties"
  vagrant ssh -c "sudo add-apt-repository ppa:chris-lea/node.js"
  vagrant ssh -c "sudo apt-get update"
  vagrant ssh -c "sudo apt-get install nodejs"

  # Install ionic and cordova
  vagrant ssh -c "sudo npm install -g cordova ionic"
}

# Install Laravel for PHP
function install_laravel(){
  vagrant up

  vagrant ssh -c "sudo apt-get update"
  vagrant ssh -c "echo '--- MySQL ---'"
  vagrant ssh -c "sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'"
  vagrant ssh -c "sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'"
  vagrant ssh -c "sudo apt-get install -y vim curl python-software-properties"
  vagrant ssh -c "sudo add-apt-repository -y ppa:ondrej/php5"
  vagrant ssh -c "sudo apt-get update"
  vagrant ssh -c "sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql git-core"
  vagrant ssh -c "sudo a2enmod rewrite"
  vagrant ssh -c "sudo service apache2 restart"
  vagrant ssh -c "curl -sS https://getcomposer.org/installer | php"
  vagrant ssh -c "sudo mv composer.phar /usr/local/bin/composer"
  vagrant ssh -c "mysql -uroot -proot -e 'CREATE DATABASE main_database';"
}

# Install angular
function install_angular(){
  vagrant up

  vagrant ssh -c "sudo npm -g install karma bower gulp"
}

case "$install_option" in
  "ionic" )
    install_ionic
    ;;
  "angular" )
    install_angular
    ;;
  "rails" )
    install_rails
    ;;
  "laravel" )
    install_laravel
    ;;
esac

