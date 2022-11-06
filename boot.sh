#!/bin/sh

# build
/usr/bin/erb /usr/local/openresty/nginx/conf/nginx.conf.erb > /usr/local/openresty/nginx/conf/nginx.conf

# start nginx
/usr/local/openresty/nginx/sbin/nginx
