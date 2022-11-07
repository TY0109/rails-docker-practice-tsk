# 1 /tmp/nginx.socketでlisten
bind "unix:///tmp/nginx.socket"
# 2 masterプロセスがworkerプロセスを生成するときに/tmp/app-initializedを生成する
require 'fileutils'
on_worker_fork do
    FileUtils.touch('/tmp/app-initialized')
end