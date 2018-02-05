#!/bin/bash

cd /tmp/epics-dev/

# Source environment variables
. ./env-vars.sh

# Source EPICS variables
. ./bash.bashrc.local

OPTS=""

# Verifies if the environment variables are defined and starts ca gateway.
if [ -v CA_GATEWAY_SIP ]; then
    OPTS="$OPTS  -sip ${CA_GATEWAY_SIP}"
fi

if [ -v CA_GATEWAY_SIGNORE ]; then
    OPTS="$OPTS -signore ${CA_GATEWAY_SIGNORE}"
fi

CIP_ADDRESSES=""
CIP_IOCS = $(env | grep "IOC_.*")

if [ -v CA_GATEWAY_CIP ]; then
    CIP_ADDRESSES="$CIP_ADDRESSES ${CA_GATEWAY_CIP}"
fi

for IOC in ${CIP_IOCS}
do
    if [[ ! $CIP_ADDRESSES = *"${IOC}"* ]]; then
        CIP_ADDRESSES="$CIP_ADDRESSES $IOC"
    fi
done

if [ -v CIP_ADDRESSES ]; then
    OPTS="$OPTS -cip ${CIP_ADDRESSES}"
fi

set -x

${CA_GATEWAY_PATH}/bin/${EPICS_HOST_ARCH}/gateway ${OPTS}


