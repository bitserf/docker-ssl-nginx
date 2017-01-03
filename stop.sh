#!/bin/bash

CONTAINER=$(docker ps | grep ssl-nginx | awk '{print $1}')

[ -z "${CONTAINER}" ] && {
	echo "error: no running ssl-nginx container found." >&2
	exit 1
}

docker stop ${CONTAINER}
docker rm ${CONTAINER}
