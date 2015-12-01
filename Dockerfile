FROM centos:centos7
MAINTAINER The BitScout Community <community@TBA>

EXPOSE 10514

ENV SYSLOG_LISTEN_PORT=10514 \
    ES_HOST=bitscout-elasticsearch \
    ES_PORT=9200

RUN yum install -y rsyslog rsyslog-elasticsearch rsyslog-gssapi \
    rsyslog-mmjsonparse rsyslog-mmsnmptrapd && \
    yum clean all

ADD rsyslog.conf /etc/rsyslog.conf
ADD rsyslog.d/* /etc/rsyslog.d/
ADD run.sh /usr/sbin/
WORKDIR /var/lib/rsyslog

CMD /usr/sbin/run.sh
