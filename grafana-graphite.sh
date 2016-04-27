export CALAVERA_HOME="/opt/Calavera-chef-provision"
NODE=monitor
docker run \
  --detach \
   --publish=8136:80 \
   --publish=8137:81 \
   --publish=8125:8125/udp \
   --publish=8126:8126 \
   --publish=2003:2003 \
   --name ${NODE} \
   kamon/grafana_graphite
    C_IP=`docker inspect --format='{{.NetworkSettings.IPAddress}}' ${NODE}`
    echo "${C_IP} ${NODE} ${NODE}.calavera.biz" >> ${CALAVERA_HOME}/dnsmasq.hosts/grafana
    docker kill -s HUP dnsmasq
# Collecting host metrics
killall collectl > /dev/null 2>&1
nohup collectl --export graphite,monitor.calavera.biz >/dev/null 2>&1 &
