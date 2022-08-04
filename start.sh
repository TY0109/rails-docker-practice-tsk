#!/bin/sh シェルスクリプト

if [ "${RAILS_ENV}" = "production" ]
then
# 本番だけで実行、cssをまとめて読み込み、htmlに適用
   bundle exec rails assets:precompile
fi

# railsサーバーの起動
bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0
