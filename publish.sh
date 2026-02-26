#!/bin/bash

# Variables
timestamp=`date "+%d-%m-%y--%H.%M.%S"`

# clean up any old versions of the site first
rm -rf public/*

# Generate the html
hugo --minify --cleanDestinationDir

# create and push the multi-arch container
podman manifest rm jturpin/jimturpin.com:$timestamp 2>/dev/null || true
podman manifest rm jturpin/jimturpin.com:latest 2>/dev/null || true
podman rmi jturpin/jimturpin.com:latest 2>/dev/null || true

podman build --platform linux/amd64,linux/arm64 --manifest jturpin/jimturpin.com:$timestamp .
podman manifest push jturpin/jimturpin.com:$timestamp docker://jturpin/jimturpin.com:$timestamp
podman manifest rm jturpin/jimturpin.com:$timestamp

podman build --platform linux/amd64,linux/arm64 --manifest jturpin/jimturpin.com:latest .
podman manifest push jturpin/jimturpin.com:latest docker://jturpin/jimturpin.com:latest
podman manifest rm jturpin/jimturpin.com:latest
