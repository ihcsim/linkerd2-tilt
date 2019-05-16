#!/bin/bash

PROJECT_HOME=${GOPATH}/src/github.com/linkerd/linkerd2
LINKERD_BIN=${PROJECT_HOME}/bin/linkerd

CLUSTER_DOMAIN=${CLUSTER_DOMAIN:-cluster.local}
NEW_TLS_ASSETS=${NEW_TLS_ASSETS:-"false"}

CA_CERT_FILE=tls/ca.crt
ISSUER_CERT_FILE=tls/identity.linkerd.cluster.local.crt
ISSUER_KEY_FILE=tls/identity.linkerd.cluster.local.key

if [ "${NEW_TLS_ASSETS}" = "true" ]; then
  source ${PROJECT_HOME}/sh/gen-tls.sh
  exit $?
fi

${LINKERD_BIN} install --ignore-cluster \
  --identity-issuer-certificate-file ${ISSUER_CERT_FILE} \
  --identity-issuer-key-file ${ISSUER_KEY_FILE} \
  --identity-trust-anchors-file ${CA_CERT_FILE} \
  --identity-trust-domain ${CLUSTER_DOMAIN}
