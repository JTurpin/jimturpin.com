#!/bin/bash

# Variables
timestamp=`date "+%d-%m-%y--%H.%M.%S"`

# clean up any old versions of the site first
rm -rf public/*

# pull latest versions of podman containers
podman pull alpine:latest
podman pull nginx:alpine

# create and push the podman container (multi-arch)
podman manifest rm docker.io/jturpin/jimturpin.com:$timestamp 2>/dev/null || true
podman manifest create docker.io/jturpin/jimturpin.com:$timestamp
podman build --platform linux/amd64,linux/arm64 --manifest docker.io/jturpin/jimturpin.com:$timestamp .
podman manifest push docker.io/jturpin/jimturpin.com:$timestamp

podman manifest rm docker.io/jturpin/jimturpin.com:latest 2>/dev/null || true
podman manifest create docker.io/jturpin/jimturpin.com:latest
podman build --platform linux/amd64,linux/arm64 --manifest docker.io/jturpin/jimturpin.com:latest .
podman manifest push docker.io/jturpin/jimturpin.com:latest
