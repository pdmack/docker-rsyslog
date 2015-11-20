#!/bin/sh

set -ex
prefix=${PREFIX:-${1:-bitscout/}}
version=${VERSION:-${2:-latest}}
docker build -t "${prefix}rsyslog:${version}" .
docker build -t "${prefix}rsyslog-app:${version}" nulecule/

if [ -n "${PUSH:-$3}" ]; then
	docker push "${prefix}rsyslog:${version}"
	docker push "${prefix}rsyslog-app:${version}"
fi
