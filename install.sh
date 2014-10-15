#!/bin/bash
# Author: Hai Nguyen

# Get install option
install_option=$1

# Ask user for install input if none give.
if [[ -z "$1" ]]; then
  printf "Please enter install option: "
  read install_option
fi

# Install ionic
function installIonic(){
  vagrant up

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

case "$install_option" in
  "ionic" )
    installIonic
    ;;
esac

