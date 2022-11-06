FROM openresty/openresty:1.13.6.1-1-alpine

ENV PATH $PATH:/usr/sbin/

COPY  nginx.conf.erb /usr/local/openresty/nginx/conf/nginx.conf.erb

COPY boot.sh /boot.sh
RUN chmod +x /boot.sh

RUN apk update \
  && apk add ruby

CMD ["/boot.sh"]
