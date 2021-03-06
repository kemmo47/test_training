#!/bin/sh

echo "================================================================================"

if [ ! -d "/myapp/node_modules" ]
then
    echo "node_modules dose not exist!"
    cd myapp || exit
    npm install
else 
    echo "node_modules dose exist!"
    if [ ! -d "/myapp/node_modules/sweetalert2" ]
    then
        echo "sweetalert2 dose not exist!"
        cd myapp || exit
        rm -rf node_modules && rm -rf package-lock.json yarn.lock && npm install
    else 
        echo "sweetalert2 dose exist!"
        cd myapp || exit
    fi
fi

bundle install
rails db:migrate RAILS_ENV=development
rails webpacker:install
rm -f tmp/pids/server.pid
rails server -b 0.0.0.0
exec "$@"
