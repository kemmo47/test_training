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
COPY /ruby.sh /

CMD ["sh", "/ruby.sh"]