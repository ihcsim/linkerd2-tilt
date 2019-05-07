#!/bin/bash

set -e

OPENSSL_CONFIG_FILE=sh/openssl.cnf

CA_CERT_FILE=${CA_CERT_FILE:-tls/ca.crt}
ISSUER_KEY_FILE=${ISSUER_KEY_FILE:-tls/identity.linkerd.cluster.local.key}
ISSUER_CERT_FILE=${ISSUE_CERT_FILE:-tls/identity.linkerd.cluster.local.crt}

CA_KEY_FILE=tls/ca.key
CA_SRL_FILE=tls/ca.srl
CERT_VALIDITY_DAYS=30

ISSUER_PUB_KEY_FILE=tls/identity.linkerd.cluster.local.key.pub
ISSUER_CSR_FILE=tls/identity.linkerd.cluster.local.csr

rm -rf ${CA_KEY_FILE} ${CA_CERT_FILE} ${CA_SRL_FILE} ${ISSUER_KEY_FILE} ${ISSUER_PUB_KEY_FILE} ${ISSUER_CSR_FILE} ${ISSUER_CERT_FILE}

openssl req -new -newkey ec:<(openssl ecparam -name prime256v1) \
  -nodes -x509 \
  -days ${CERT_VALIDITY_DAYS} \
  -config <(cat ${OPENSSL_CONFIG_FILE}) \
  -extensions v3_req \
  -keyout ${CA_KEY_FILE} \
  -out ${CA_CERT_FILE}

ssh-keygen -t ecdsa -b 256 -f ${ISSUER_KEY_FILE} -N ""

openssl req -new \
  -key ${ISSUER_KEY_FILE} \
  -out ${ISSUER_CSR_FILE} \
  -config ${OPENSSL_CONFIG_FILE}

openssl x509 -req \
  -days ${CERT_VALIDITY_DAYS} \
  -in ${ISSUER_CSR_FILE} \
  -CA ${CA_CERT_FILE} \
  -CAkey ${CA_KEY_FILE} \
  -CAcreateserial \
  -extensions v3_req \
  -extfile ${OPENSSL_CONFIG_FILE} \
  -out ${ISSUER_CERT_FILE}
