#!/bin/bash

bindir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
linkerd_bin=${bindir}/linkerd

CLUSTER_DOMAIN=${CLUSTER_DOMAIN:-cluster.local}
NEW_TLS_ASSETS=${NEW_TLS_ASSETS:-"false"}

if [ "${NEW_TLS_ASSETS}" = "true" ]; then
  source ${bindir}/tilt-gen-tls.sh
  exit $?
fi

ca_cert_file=${tlsdir}/ca.crt
issuer_key_file=${tlsdir}/identity.linkerd.cluster.local.key
issuer_cert_file=${tlsdir}/identity.linkerd.cluster.local.crt
${linkerd_bin} install \
  --identity-issuer-certificate-file ${issuer_cert_file} \
  --identity-issuer-key-file ${issuer_key_file} \
  --identity-trust-anchors-file ${ca_cert_file} \
  --identity-trust-domain ${CLUSTER_DOMAIN} \
  $@
