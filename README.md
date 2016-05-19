# docker-rsyslog
ViaQ rsyslog docker container - implements the aggregator/formatter

## Environmental variables:
`ES_HOST` must be FQDN of ElasticSearch server.  
`ES_PORT` must be the port on which the ElasticSearch server is listening.  
`SYSLOG_LISTEN_PORT` the port this rsyslog instance is listening for. both TCP and UDP.  

## External rsyslog config
In order to add own rsyslog configuration file please add the configuration files to a local directory and map in to `/data` docker volume.  
The following files are taken form the local directory:  
`rsyslog.conf, rsyslog.d/*.conf`  
In case `rsyslog.conf` exists, the default `rsyslog.d/*.conf` is removed and not used in the container.

## Running:
docker run -d -p $syslog_listen_port:$syslog_listen_port/tcp -p $syslog_listen_port:$syslog_listen_port/udp -v $local_dir:/data -u $uid -e ES_HOST=$elasticsearchhost -e ES_PORT=$port -e SYSLOG_LISTEN_PORT=$syslog_listen_port -e NORMALIZER_NAME=container-rsyslog8.17 -e NORMALIZER_IP=$normalizer_ip -e LOGSTASH_PREFIX=v2016.03.10.0-viaq- --name $appname $image

