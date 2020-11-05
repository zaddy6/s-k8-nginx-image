FROM nginx:1.19.3-alpine

LABEL version = "1.0.0"
LABEL author =  "Glasswall Solutions"

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache openssl

COPY files /

RUN mkdir /etc/nginx/ssl

ENTRYPOINT \
  openssl req \
    -subj '/CN=localhost' \
    -x509 -newkey rsa:4096 \
    -nodes -keyout /etc/nginx/ssl/default_key.pem \
    -out /etc/nginx/ssl/default_cert.pem \
    -days 365 && \
  nginx -g 'daemon off;'