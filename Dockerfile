FROM klakegg/hugo:ext-alpine as build
LABEL Maintainer="jim@jimturpin.com"

COPY ./ /src
WORKDIR /src
RUN hugo

#Copy static files to Nginx
FROM nginx:1.25.4-alpine3.18
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
WORKDIR /usr/share/nginx/html