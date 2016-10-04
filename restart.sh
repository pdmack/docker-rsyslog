for container_id in $(docker ps  --filter="name=rsyslog-normalizer" -q -a);
do
  docker stop $container_id &&
  docker rm $container_id;
  echo "Stopped & Removed the container!"
done

if [ "$DEBUG" = true ]; then
  ENV_DEBUG="-e DEBUG_RSYSLOG=true"
  LOG=""
else
  ENV_DEBUG="-e DEBUG_RSYSLOG=false"
  LOG=""
fi

docker run -p 10514:10514/tcp -p 10514:10514/udp -v /home/centos/src/docker-rsyslog/data/:/data -e NORMALIZER_NAME=container-rsyslog8.17 -e NORMALIZER_IP=172.17.77.14 -e LOGSTASH_PREFIX=viaq-openshift-v2016.05.16.1- -e ES_HOST=10.3.13.42 -e ES_PORT=9200 -e SYSLOG_LISTEN_PORT=10514 ${ENV_DEBUG} --name rsyslog-normalizer t0ffel/rsyslog ${LOG}
