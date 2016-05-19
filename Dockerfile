FROM centos:centos7
MAINTAINER The ViaQ Community <community@TBA>

EXPOSE 10514

ENV SYSLOG_LISTEN_PORT=10514 \
    ES_HOST=bitscout-elasticsearch \
    ES_PORT=9200

RUN curl https://copr.fedorainfracloud.org/coprs/portante/rsyslog-8.17/repo/epel-7/portante-rsyslog-8.17-epel-7.repo > /etc/yum.repos.d/portante-rsyslog-v8.17-epel-7.repo && \
    yum install -y rsyslog rsyslog-elasticsearch rsyslog-gssapi \
    rsyslog-mmjsonparse && \
    yum clean all

VOLUME /data

ADD run.sh /usr/sbin/
WORKDIR /var/lib/rsyslog

CMD /usr/sbin/run.sh
