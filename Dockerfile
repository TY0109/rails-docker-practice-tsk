FROM ruby:3.1.4

ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn \
  && apt-get install -y vim

WORKDIR /app

COPY ./src /app

RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

# Dockerfileには条件分岐を書きたくないので、start.shに本番環境用の処理を記載している
COPY start.sh /start.sh
# 実行権限の付与
RUN chmod 744 /start.sh
# 実行コマンド
CMD ["sh", "/start.sh"]
# nginxとUnixソケット通信を行うためのpuma.sockファイルを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
