FROM alpine:latest as build
LABEL Maintainer="jim@jimturpin.com"

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo

COPY ./ /src
WORKDIR /src
RUN hugo --minify --cleanDestinationDir

#Copy static files to Nginx
FROM nginx:alpine
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
WORKDIR /usr/share/nginx/html