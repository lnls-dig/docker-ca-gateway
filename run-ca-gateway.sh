#!/bin/bash

# Verifies if the environment variables are defined and starts ca gateway.

if [ -v CA_GATEWAY_SIP ]; then
    OPTS=$OPTS:" -sip ${CA_GATEWAY_SIP}"
fi 

if [ -v CA_GATEWAY_SIGNORE ]; then
    OPTS=$OPTS:" -signore ${CA_GATEWAY_SIGNORE}"
fi 

if [ -v CA_GATEWAY_CIP ]; then
    OPTS=$OPTS:" -cip ${CA_GATEWAY_CIP}"
fi 

set -x

${CA_GATEWAY_PATH}/bin/${EPICS_HOST_ARCH}/gateway ${OPTS}

