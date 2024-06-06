# Pumaサーバーを起動し、スレッド数やポート番号、ログの出力先などを設定

# 環境変数 RAILS_MAX_THREADS からスレッド数を取得し、それがない場合はデフォルト値として5を使用
# 今回はRAILS_MAX_THREADSを設定していないので、5を使用

# Pumaはマルチスレッドで動作し、1つのスレッドが1つのリクエストを処理します。したがって、スレッド数が5であれば、Pumaは同時に最大5つのリクエストを処理できます。
# Pumaが同時に処理できるリクエストの数が5であることを意味します。これは、並列処理のためのスレッドプールのサイズを指定しています。つまり、Pumaは同時に5つのリクエストを処理でき、それ以上のリクエストが来た場合は、それらがキューに入れられて順番に処理されます。
# これは5人のユーザーからのリクエストとは限りません。
# 具体的には、1つのユーザーが同時に複数のリクエストを送信することもあります。例えば、ウェブページをロードする際に、HTMLコンテンツや画像、スタイルシート、JavaScriptファイルなど複数のファイルを同時に取得するために、1つのページロードに複数のリクエストが生成されることがあります。
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
plugin :tmp_restart

# Unixソケットを使用してPumaが接続を受け入れるためのバインドアドレスを設定します。これにより、外部のWebサーバーNginxがPumaに接続できます。
app_root = File.expand_path("../..", __FILE__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"

# Pumaの標準出力と標準エラー出力をログファイルにリダイレクトします。
# Pumaが起動したときや停止したときなど、重要なイベントの詳細を表示
# 例) === puma startup: 2024-06-05 23:39:24 +0000 ===
#     - Gracefully stopping, waiting for requests to finish
stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true
# cf 以下のようなRailsアプリケーションの実際の処理に関するログはここには記録されない(development.logに記録)
# Processing by UsersController#show as HTML
# Parameters: {"id"=>"1"}
# User Load (5.6ms)  SELECT `users`.* FROM `users` WHERE `users`.`id` = 1 LIMIT 1
# ↳ app/controllers/users_controller.rb:7:in `show'
