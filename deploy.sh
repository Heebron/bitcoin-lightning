#!/bin/bash

docker stop bitcoind
docker rm bitcoind

docker run \
       --detach \
       --name bitcoind \
       --restart unless-stopped \
       --volume /mnt/utility/bitcoin:/data \
       --publish 8332:8332 \
       --publish 8333:8333 \
       kpratt/bitcoind
