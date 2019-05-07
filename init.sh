#!/bin/bash

PROJECT_HOME=$GOPATH/src/github.com/linkerd/linkerd2
LINKERD_BIN=linkerd

CLUSTER_DOMAIN=${CLUSTER_DOMAIN:-cluster.local}
CA_CERT_FILE=tls/ca.crt
ISSUER_CERT_FILE=tls/identity.linkerd.cluster.local.crt
ISSUER_KEY_FILE=tls/identity.linkerd.cluster.local.key
REGENERATE_TLS_ASSETS="true"

source ${PROJECT_HOME}/tls/gen-tls.sh > /dev/null 2>&1

${LINKERD_BIN} install --ignore-cluster \
  --identity-issuer-certificate-file ${ISSUER_CERT_FILE} \
  --identity-issuer-key-file ${ISSUER_KEY_FILE} \
  --identity-trust-anchors-file ${CA_CERT_FILE} \
  --identity-trust-domain ${CLUSTER_DOMAIN}
