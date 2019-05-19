#!/bin/bash

PROJECT_HOME=${GOPATH}/src/github.com/linkerd/linkerd2
SCRIPTS_HOME=${PROJECT_HOME}/bin

name=$1
case $name in
  controller)
    tag=$(${SCRIPTS_HOME}/docker-build-controller)
    ;;
  web)
    tag=$(${SCRIPTS_HOME}/docker-build-web)
    ;;
  proxy)
    tag=$(${SCRIPTS_HOME}/docker-build-proxy)
    ;;
  proxy-init)
    tag=$(${SCRIPTS_HOME}/docker-build-proxy-init)
    ;;
  grafana)
    tag=$(${SCRIPTS_HOME}/docker-build-grafana)
    ;;
esac
docker tag $tag $EXPECTED_REF
