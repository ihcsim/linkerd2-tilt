#!/bin/bash

PROJECT_HOME=${GOPATH}/src/github.com/linkerd/linkerd2
SCRIPTS_HOME=${PROJECT_HOME}/bin

source ${SCRIPTS_HOME}/_tag.sh
tag="$(head_root_tag)"
printf "${tag}"
