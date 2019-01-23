FROM node:10-alpine as build

WORKDIR /src
ADD . /src

RUN npm install --production
RUN npm run build

FROM nginx

WORKDIR /usr/share/nginx/html

ADD /nginx.default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/build /usr/share/nginx/html