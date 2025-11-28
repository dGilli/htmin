#FROM nginx:mainline
FROM alpine:3.22.2

RUN apk add --no-cache nginx

RUN mkdir -p /run/nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d \
 && chown -R nginx:nginx /var/cache/nginx /var/log/nginx

COPY nginx/head-tags.conf /etc/nginx/head-tags.conf
COPY nginx/default.conf /etc/nginx/http.d/default.conf

WORKDIR /usr/share/nginx/html

EXPOSE 80

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
