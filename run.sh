#!/bin/sh

set -e
set -x

ES_HOST=${ES_HOST:-viaq-elasticsearch}
ES_PORT=${ES_PORT:-9200}
SYSLOG_LISTEN_PORT=${SYSLOG_LISTEN_PORT:-10514}
DEBUG_RSYSLOG=${DEBUG_RSYSLOG:-true}
LOGSTASH_PREFIX=${LOGSTASH_PREFIX:-logstash-}
NORMALIZER_NAME=${NORMALIZER_NAME:-container-rsyslog8.17}
NORMALIZER_IP=${NORMALIZER_IP:-172.17.77.14}

if [ "$DEBUG_RSYSLOG" = true ]; then
    RSYSLOG_ARGS="-d -n"
else
    RSYSLOG_ARGS="-n"
fi

if [ -f "/data/rsyslog.conf" ]; then
    cp /data/rsyslog.conf /etc/rsyslog.conf
    rm /etc/rsyslog.d/*.conf
    if [ -d "/data/rsyslog.d" ]; then
        cp -R /data/rsyslog.d /etc/
    fi
fi

for file in /etc/rsyslog.conf /etc/rsyslog.d/*.conf ; do
    if [ ! -f "$file" ] ; then continue ; fi
    sed -i -e "s/%ES_HOST%/$ES_HOST/g" -e "s/%ES_PORT%/$ES_PORT/g" \
        -e "s/%SYSLOG_LISTEN_PORT%/$SYSLOG_LISTEN_PORT/g" \
        -e "s/%LOGSTASH_PREFIX%/$LOGSTASH_PREFIX/g" \
        -e "s/%NORMALIZER_NAME%/$NORMALIZER_NAME/g" -e "s/%NORMALIZER_IP%/$NORMALIZER_IP/g" \
        "$file"
done
/usr/sbin/rsyslogd ${RSYSLOG_ARGS}

