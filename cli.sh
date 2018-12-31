#!/bin/bash

container_name="core_bitcoin-lightning"
instance="1"

echo container_id=${container_name}.${instance}.$(docker service ps -f name=${container_name}.${instance} ${container_name} -q --no-trunc)
exit 1

if [[ "$container_id" != "" ]] ; then
    docker exec -it "$container_id" /lightning/cli/lightning-cli --lightning-dir=/data/lightning/ "$@"
else
    echo "'core_bitcoin' is not running."
fi
