# アプリを生成するための処理？
FROM ruby:2.7

# 環境変数を設定
ENV RAILS_ENV=production

# node.jsとyarnのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn \
  # vimのインストールを追記
  && apt-get install -y vim
# docker側のディレクトリを作成
WORKDIR /app
# srcフォルダ（appフォルダとgemfile）を、docker側のディレクトリの配下に置く。
COPY ./src /app

# 追記
RUN gem install bundler

# bundle installでアプリ生成時に、gemもいくつか追加（それ以降はコマンドで手入力）
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
# CMD サーバーの起動は今回は、ここには書かない。

# dockerfileでは条件分岐を書かない。start.shに記載しよう
# docker側にコピー
COPY start.sh /start.sh
# 実行権限の付与
RUN chmod 744 /start.sh
# 実行コマンド
CMD ["sh", "/start.sh"]
