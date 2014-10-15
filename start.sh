#!/bin/bash
# Author: Hai Nguyen

# Get app type and name of app.
app_type=$1
app_name=$2

# Check to make sure app type and name exists.
if [[ -z "$1" ]]; then
  printf "Please enter application type: "
  read app_type
fi

if [[ -z "$2" ]]; then
  printf "Please enter application directory name: "
  read app_name
fi

function start_rails(){
  vagrant up

  vagrant ssh -c "cd /vagrant/$app_name && bundle && bundle exec rake db:create && bundle exec rake db:migrate && rails s -p 3000"
}


case "$app_type" in
  "rails" )
    start_rails
    ;;
esac