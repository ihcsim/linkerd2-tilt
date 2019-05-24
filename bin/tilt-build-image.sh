#!/bin/bash

bindir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

name=$1
case $name in
  controller)
    tag=$(${bindir}/docker-build-controller)
    ;;
  web)
    tag=$(${bindir}/docker-build-web)
    ;;
  proxy)
    tag=$(${bindir}/docker-build-proxy)
    ;;
  proxy-init)
    tag=$(${bindir}/docker-build-proxy-init)
    ;;
  grafana)
    tag=$(${bindir}/docker-build-grafana)
    ;;
esac
docker tag $tag $EXPECTED_REF
