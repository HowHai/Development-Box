#!/bin/bash
# Author: Hai Nguyen

# Get install option
install_option=$1

# Ask user for install input if none give.
if [[ -z "$1" ]]; then
  echo "Available options: ionic, angular"
  printf "Please enter install option: "
  read install_option
fi

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

# Install angular
function install_angular(){
  vagrant up

  vagrant ssh -c "sudo npm -g install grunt-cli karma bower"
}

case "$install_option" in
  "ionic" )
    install_ionic
    ;;
  "angular" )
    install_angular
    ;;
esac

