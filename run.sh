#!/bin/sh

set -e
set -x

ES_HOST=${ES_HOST:-bitscout-elasticsearch}
ES_PORT=${ES_PORT:-9200}
SYSLOG_LISTEN_PORT=${SYSLOG_LISTEN_PORT:-10514}

for file in /etc/rsyslog.conf /etc/rsyslog.d/*.conf ; do
    if [ ! -f "$file" ] ; then continue ; fi
    sed -i -e "s/%ES_HOST%/$ES_HOST/g" -e "s/%ES_PORT%/$ES_PORT/g" \
        -e "s/%SYSLOG_LISTEN_PORT%/$SYSLOG_LISTEN_PORT/g" \
        "$file"
done
/usr/sbin/rsyslogd -d -n
