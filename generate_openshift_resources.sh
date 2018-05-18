#!/bin/sh

oc create configmap rsyslog-d-conf --from-file rsyslog.d/
oc apply -f openshift/rsyslog-deployment.yaml
oc apply -f openshift/rsyslog-service.yaml
