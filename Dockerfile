FROM ruby
# RUN apk update && apk add --virtual build-dependencies build-base
RUN gem install rails -v 6.1.0
RUN gem install bundler

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
    apt-get install build-essential -y --no-install-recommends \
    vim \
    git \
    gnupg2 \
    curl \
    wget \
    nodejs \
    yarn \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    libmariadb-dev

RUN apt-get install -y sqlite3
# COPY /ruby.sh /
# Create bash script to start service
RUN printf '#!/bin/bash \n \
echo "================================================================================" \n \
if [ ! -d "/myapp/node_modules" ] \n \
then \n \
    echo "node_modules dose not exist!" \n \
    cd myapp || exit \n \
    npm install \n \
else  \n \
    echo "node_modules dose exist!" \n \
    if [ ! -d "/myapp/node_modules/sweetalert2" ] \n \
    then \n \
        echo "sweetalert2 dose not exist!" \n \
        cd myapp || exit \n \
        rm -rf node_modules && rm -rf package-lock.json yarn.lock && npm install \n \
    else  \n \
        echo "sweetalert2 dose exist!" \n \
        cd myapp || exit \n \
    fi \n \
fi \n \
bundle install \n \
rails db:migrate RAILS_ENV=development \n \
rails webpacker:install \n \
rm -f tmp/pids/server.pid \n \
rails server -b 0.0.0.0 \n \
exec "$@"' > /ruby.sh


RUN chmod +x /ruby.sh
CMD ["sh", "/ruby.sh"]