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

KAFKA_HOST=${1:-"one-kafka.dh-stage-message-bus.svc.cluster.local:9092"}

sed -i -e "s/%KAFKA_HOST%/$KAFKA_HOST/g" ../rsyslog.d/50-kafka-output.conf

oc project ${NAMESPACE}
oc create configmap rsyslog-d-conf -n ${NAMESPACE} ${USE_KUBECONFIG} --from-file ../rsyslog.d --dry-run -o yaml > /tmp/rsyslog-d-conf.yaml
oc apply -f /tmp/rsyslog-d-conf.yaml ${USE_KUBECONFIG}

oc apply -f rsyslog-deployment.yaml -n ${NAMESPACE} ${USE_KUBECONFIG}

oc apply -f rsyslog-service.yaml -n ${NAMESPACE} ${USE_KUBECONFIG}

oc apply -f rsyslog-external-service.yaml -n ${NAMESPACE} ${USE_KUBECONFIG}
