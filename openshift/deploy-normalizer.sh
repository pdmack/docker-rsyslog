#!/bin/sh

NAMESPACE=${NAMESPACE:-dh-stage-ingest}

oc create configmap rsyslog-d-conf -n ${NAMESPACE} --from-file ../rsyslog.d --dry-run -o yaml > /tmp/rsyslog-d-conf.yaml
oc apply -f /tmp/rsyslog-d-conf.yaml

oc apply -f rsyslog-deployment.yaml -n ${NAMESPACE}

oc apply -f rsyslog-service.yaml -n ${NAMESPACE}
