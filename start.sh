#!/bin/sh シェルスクリプト

if [ "${RAILS_ENV}" = "production" ]
then
  bundle exec rails assets:precompile
fi
