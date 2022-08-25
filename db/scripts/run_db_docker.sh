#!/bin/bash

docker run -d \
    --name mongodb \
    -p 27017:27017 \
    -v data:/data/db \
    -e MONGO_INITDB_ROOT_USERNAME=admin \
    -e MONGO_INITDB_ROOT_PASSWORD=admin \
    mongo
