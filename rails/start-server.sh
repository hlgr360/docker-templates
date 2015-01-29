#!/bin/bash -l
# Note: We need to run this script as login shell to get the path setup
cd /app
bundle install
# bundle exec rake db:reset
bundle exec rails server -p 3000