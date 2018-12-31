#!/bin/bash

docker run \
       -it --rm \
       --name bitcoind-cmdline \
       --volume /mnt/utility/bitcoin:/data \
       --publish 8332:8332 \
       --publish 8333:8333 \
       --entrypoint /bin/bash \
       kpratt/bitcoind
