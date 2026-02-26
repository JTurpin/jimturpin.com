FROM klakegg/hugo:ext-alpine AS build
LABEL Maintainer="jim@jimturpin.com"

RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo

COPY ./ /src
WORKDIR /src
RUN hugo --minify --cleanDestinationDir

# Minimal static file server - no OS, no vulnerabilities
FROM joseluisq/static-web-server:2-alpine AS server

FROM scratch
COPY --from=server /usr/local/bin/static-web-server /static-web-server
COPY --from=build /src/public /public
EXPOSE 80
ENTRYPOINT ["/static-web-server", "--port", "80", "--root", "/public"]