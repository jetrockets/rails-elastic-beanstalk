#!/bin/sh

bundle exec rake db:migrate
# bundle exec puma -C /app/puma.rb
RAILS_ENV=$RAILS_ENV bundle exec puma -t 1:16 -w 1 --preload -b tcp://0.0.0.0:3000 --pidfile=/app/server.pid
