#!/bin/bash
# Author: Hai Nguyen

# Get app type and name of app.
app_type=$1
app_name=$2

if [[ -z "$1" ]]; then
  echo "Available app types: laravel"
  printf "Please enter application type: "
  read app_type
fi

if [[ -z "$2" ]]; then
  printf "Please enter application directory name: "
  read app_name
fi

function new_laravel(){
  vagrant up

  vagrant ssh -c "cd /vagrant && composer create-project laravel/laravel $app_name --prefer-dist"
}

case "$app_type" in
  "laravel" )
    new_laravel
    ;;
esac