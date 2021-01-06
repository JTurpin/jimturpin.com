#!/bin/bash

# Generate the html
hugo --minify --cleanDestinationDir

# create the docker container
docker build -t jturpin/jimturpin.com .

# push the container to dockerhub
docker push jturpin/jimturpin.com
