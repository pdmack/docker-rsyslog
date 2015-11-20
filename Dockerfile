FROM centos:centos7
MAINTAINER The BitScout Community <community@TBA>

EXPOSE 5140

RUN yum install -y rsyslog rsyslog-elasticsearch rsyslog-gssapi \
    rsyslog-mmjsonparse rsyslog-mmsnmptrapd && \
    yum clean all

ADD rsyslog.conf /etc/rsyslog.conf
ADD rsyslog.d/* /etc/rsyslog.d/
WORKDIR /var/lib/rsyslog

CMD ["/usr/sbin/rsyslogd", "-d", "-n"]
