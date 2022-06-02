#!/bin/bash

# Variables
timestamp=`date "+%d-%m-%y--%H.%M.%S"`

# clean up any old versions of the site first
rm -rf public/*

# Generate the html
hugo --minify --cleanDestinationDir

# create and push the docker container
docker build -t jturpin/jimturpin.com:$timestamp .
docker build -t jturpin/jimturpin.com:latest . 
docker buildx build --platform linux/amd64,linux/arm64 --push -t jturpin/jimturpin.com:$timestamp .
docker buildx build --platform linux/amd64,linux/arm64 --push -t jturpin/jimturpin.com:latest .
