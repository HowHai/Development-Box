#!/bin/bash
# Author: Hai Nguyen

# Get app type and name of app.
app_type=$1
app_name=$2

# Check to make sure app type and name exists.
if [[ -z "$1" ]]; then
  echo "Available app types: rails, ionic, angular, laravel"
  printf "Please enter application type: "
  read app_type
fi

if [[ -z "$2" ]]; then
  printf "Please enter application directory name: "
  read app_name
fi

function start_rails(){
  vagrant up

  vagrant ssh -c "cd /vagrant/$app_name && bundle && bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed && rails s -p 3000"
}

function start_ionic(){
  vagrant up

  vagrant ssh -c "cd /vagrant/$app_name && ionic serve 5000 5001"
}

function start_angular(){
  vagrant up

  vagrant ssh -c "cd /vagrant/$app_name && sudo npm install && bower install && gulp serve"
}

function start_laravel(){
  vagrant up

  vagrant ssh -c "cd /vagrant/$app_name && sudo composer install && php artisan serve --host 0.0.0.0 --port 8000"
}

case "$app_type" in
  "rails" )
    start_rails
    ;;
  "ionic" )
    start_ionic
    ;;
  "angular" )
    start_angular
    ;;
  "laravel" )
    start_laravel
    ;;
esac