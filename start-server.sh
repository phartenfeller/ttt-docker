#!/bin/bash

cd ./gmod-base

./srcds_run -game garrysmod -norestart -port ${PORT} \
 +maxplayers ${MAXPLAYERS} \
 +hostname "${HOSTNAME}" \
 +gamemode ${GAMEMODE}\
 +host_workshop_collection ${HOST_WORKSHOP_COLLECTION} \
 +rcon_password ${RCON_PASS} \
 +map ${MAP}
