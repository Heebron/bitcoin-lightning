#!/bin/bash

# maintainer: kenpratt@comcast.net

# make sure dirs exist
mkdir -p /data/bitcoin /data/lightning

# start up bitcoin daemon
/usr/bin/bitcoind -printtoconsole -datadir=/data/bitcoin &
PID1="$!"

if [[ ${ALIAS} != "" ]] ; then
    alias="--alias ${ALIAS}"
else
    alias=""
fi

if [[ ${ADDR} != "" ]] ; then
    addr="--addr ${ADDR}"
else
    addr="--addr 0.0.0.0:9735"
fi

if [[ ${ANNOUNCE_ADDR} != "" ]] ; then
    announce_addr="--announce-addr ${ANNOUNCE_ADDR}"
else
    announce_addr=""
fi

sleep 120

# start up lightning daemon
/lightning/lightningd/lightningd \
    --bitcoin-datadir=/data/bitcoin \
    --lightning-dir=/data/lightning \
    ${alias} ${addr} ${announce_addr} \
    --log-level=debug \
    --network=bitcoin &
PID2="$!"

trap 'kill $PID2 ; kill $PID1' SIGTERM

wait
