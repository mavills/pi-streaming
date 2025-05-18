#!/bin/bash

set -e
set -o pipefail

THING_NAME="RaspberryPiThing"
THING_TYPE="RaspberryPiType"
POLICY_NAME="RaspberryPiPolicy"
CERT_DIR="./certs"
CERTIFICATE_FILE="${CERT_DIR}/certificate.pem.crt"
PRIVATE_KEY_FILE="${CERT_DIR}/private.pem.key"
ROOT_CA_FILE="${CERT_DIR}/AmazonRootCA1.pem"
IOT_ROLE_ALIAS="RaspberryPiRoleAlias"

mkdir -p ${CERT_DIR}

echo "Creating keys and certificate..."
CERT_OUTPUT=$(aws iot create-keys-and-certificate --set-as-active)
CERT_ARN=$(echo ${CERT_OUTPUT} | jq -r '.certificateArn')
CERT_ID=$(echo ${CERT_OUTPUT} | jq -r '.certificateId')
CERT_PEM=$(echo ${CERT_OUTPUT} | jq -r '.certificatePem')
PRIVATE_KEY=$(echo ${CERT_OUTPUT} | jq -r '.keyPair.PrivateKey')

echo "${CERT_PEM}" > ${CERTIFICATE_FILE}
echo "${PRIVATE_KEY}" > ${PRIVATE_KEY_FILE}

echo "Downloading Root CA..."
curl -o ${ROOT_CA_FILE} https://www.amazontrust.com/repository/AmazonRootCA1.pem

echo "Setup complete. Certificates are stored in the '${CERT_DIR}' directory."
