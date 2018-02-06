FROM nginx

WORKDIR /usr/share/nginx/html

ADD /nginx.default.conf /etc/nginx/conf.d/default.conf
ADD /build /usr/share/nginx/html