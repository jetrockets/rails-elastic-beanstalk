ARG RUBY_VERSION_IMAGE=2.6.5
FROM ruby:${RUBY_VERSION_IMAGE}-slim-buster

ARG APP_PATH="/app"
ARG APP_USER=app
ARG NODE_VERSION=12
ARG POSTGRES_VERSION=12

RUN adduser --disabled-password --home ${APP_PATH} --gecos '' ${APP_USER}

RUN mkdir -p ${APP_PATH} && \
    chown ${APP_USER}. ${APP_PATH}

# Install packages
RUN apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release \
    gcc \
    g++ \
    git \
    openssh-client \
    libxml2-dev \
    libxslt-dev \
    libjemalloc2 \
    make \
    nginx \
    pkg-config \
    file \
    imagemagick

# Nginx settings
RUN touch /run/nginx.pid && \
    chown -R ${APP_USER}. /run/nginx.pid && \
    chown -R ${APP_USER}. /var/log/nginx && \
    chown -R ${APP_USER}. /var/lib/nginx && \
    chown -R ${APP_USER}. /etc/nginx/conf.d && \
    chown -R ${APP_USER}. /usr/share/nginx && \
    # Review later
    unlink /etc/nginx/sites-enabled/default

# Forward request logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

# Add Node.js repo
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://deb.nodesource.com/node_${NODE_VERSION}.x $(lsb_release -s -c) main" | tee /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/node_${NODE_VERSION}.x $(lsb_release -s -c) main" | tee -a /etc/apt/sources.list.d/nodesource.list

# Add yarn repo
RUN curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -qq && \
    apt-get install -qy --no-install-recommends \
    nodejs \
    yarn

RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" | tee /etc/apt/sources.list.d/postgresql.list

# Install dependency for gem pg
RUN apt-get update -qq && \
    apt-get install -qy --no-install-recommends libpq-dev postgresql-client-${POSTGRES_VERSION}


COPY --chown=${APP_USER}:${APP_USER} . ${APP_PATH}

USER ${APP_USER}

ENV GEM_HOME=${APP_PATH}/bundle \
    BUNDLE_PATH=${APP_PATH}/bundle \
    BUNDLE_BIN=${APP_PATH}/bundle/bin \
    PATH=${APP_PATH}/bin:${APP_PATH}/bundle/bin:/usr/local/bin:$PATH

WORKDIR ${APP_PATH}

# Install dependences
# Ruby-2.6.5 supplied with bundler:1.17.2
RUN gem install bundler -v '2.1.4'

RUN bundle install --jobs=$(nproc)
RUN yarn install --check-files
