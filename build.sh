#!/bin/bash

image=kjpratt/bitcoin-lightning

docker build --pull -t ${image} .
docker tag $image pegasus:5000/$image
docker push pegasus:5000/$image
docker push $image
