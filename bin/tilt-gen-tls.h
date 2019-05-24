#!/bin/bash

set -e

bindir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tlsdir=.tls

openssl_config_file=${bindir}/tilt-openssl.cnf
cert_validity_days=30
ca_cert_file=${tlsdir}/ca.crt
ca_key_file=${tlsdir}/ca.key
issuer_key_file=${tlsdir}/identity.linkerd.cluster.local.key
issuer_cert_file=${tlsdir}/identity.linkerd.cluster.local.crt
issuer_pub_key_file=${tlsdir}/identity.linkerd.cluster.local.key.pub
issuer_csr_file=${tlsdir}/identity.linkerd.cluster.local.csr

rm -rf ${tlsdir}
mkdir -p ${tlsdir}

openssl req -new -newkey ec:<(openssl ecparam -name prime256v1) \
  -nodes -x509 \
  -days ${cert_validity_days} \
  -config <(cat ${openssl_config_file}) \
  -extensions v3_req \
  -keyout ${ca_key_file} \
  -out ${ca_cert_file}

ssh-keygen -t ecdsa -b 256 -f ${$issuer_key_file} -N ""

openssl req -new \
  -key ${$issuer_key_file} \
  -out ${issuer_csr_file} \
  -config ${openssl_config_file}

openssl x509 -req \
  -days ${cert_validity_days} \
  -in ${issuer_csr_file} \
  -CA ${ca_cert_file} \
  -CAkey ${ca_key_file} \
  -CAcreateserial \
  -extensions v3_req \
  -extfile ${openssl_config_file} \
  -out ${issuer_cert_file}
