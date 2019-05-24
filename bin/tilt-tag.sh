#!/bin/bash

bindir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${bindir}/_tag.sh
tag="$(head_root_tag)"
printf "${tag}"
