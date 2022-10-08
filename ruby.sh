#!/bin/sh

echo "================================================================================"

# if [ ! -d "/my_ruby/node_modules" ]
# then
#     echo "node_modules dose not exist!"
#     cd my_ruby || exit
#     npm install
# else
#     echo "node_modules dose exist!"
#     if [ ! -d "/my_ruby/node_modules/sweetalert2" ]
#     then
#         echo "sweetalert2 dose not exist!"
#         cd my_ruby || exit
#         rm -rf node_modules && rm -rf package-lock.json yarn.lock && npm install
#     else
#         echo "sweetalert2 dose exist!"
#         cd my_ruby || exit
#     fi
# fi
# echo "--------------------- bundle install ---------------------"
# bundle install

# echo "--------------------- rails db:migrate RAILS_ENV=development ---------------------"
# rails db:migrate RAILS_ENV=development

echo "--------------------- rm -f tmp/pids/server.pid ---------------------"
rm -f tmp/pids/server.pid

echo "--------------------- rails server -b 0.0.0.0 ---------------------"
rails server -b 0.0.0.0
exec "$@"
