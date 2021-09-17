#!/bin/bash

# Variables
timestamp=`date "+%d-%m-%y--%H.%M.%S"`

# clean up any old versions of the site first
rm -rf public/*

# Generate the html
hugo --minify --cleanDestinationDir

# create the docker container
docker build -t jturpin/jimturpin.com:$timestamp .
docker build -t jturpin/jimturpin.com:latest . 

# push the container to dockerhub
docker push jturpin/jimturpin.com:$timestamp
docker push jturpin/jimturpin.com:latest
