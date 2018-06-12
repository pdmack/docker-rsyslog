#!/bin/sh

set -x
set -o errexit
set -o nounset
set -o pipefail

export NAMESPACE=${NAMESPACE:-dh-stage-ingest}

if [ ${KUBECONFIG:-""} = "" ]; then
    export USE_KUBECONFIG=""
else
	export USE_KUBECONFIG="--config ${KUBECONFIG}"
fi

oc project ${NAMESPACE}
oc create configmap rsyslog-d-conf -n ${NAMESPACE} ${USE_KUBECONFIG} --from-file ../rsyslog.d --dry-run -o yaml > /tmp/rsyslog-d-conf.yaml
oc apply -f /tmp/rsyslog-d-conf.yaml ${USE_KUBECONFIG}

oc apply -f rsyslog-deployment.yaml -n ${NAMESPACE} ${USE_KUBECONFIG}

oc apply -f rsyslog-service.yaml -n ${NAMESPACE} ${USE_KUBECONFIG}

oc apply -f rsyslog-external-service.yaml -n ${NAMESPACE} ${USE_KUBECONFIG}
