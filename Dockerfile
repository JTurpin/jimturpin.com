FROM klakegg/hugo:alpine as build
LABEL Maintainer="jim@jimturpin.com"

COPY ./ /src
WORKDIR /src
RUN hugo

#Copy static files to Nginx
FROM nginx:1-alpine
COPY --from=build /src/public /usr/share/nginx/html

WORKDIR /usr/share/nginx/html