#!/usr/bin/env bash
# Apache Pulsar cluster initialization
# script should be run only once at any cluster node
set -ex

# apply configuration from environment
touch ${PULSAR_BROKER_CONF}
/pulsar/bin/apply-config-from-env.py ${PULSAR_BROKER_CONF}

# is it first time run and initialization is required?
if [[ ! -f /pulsar_data/.init_done ]]; then
  /pulsar/bin/pulsar initialize-cluster-metadata \
    --configuration-store ${PULSAR_PREFIX_configurationStoreServers} \
    --zookeeper ${PULSAR_PREFIX_zookeeperServers} \
    --cluster ${PULSAR_PREFIX_clusterName} \
    --web-service-url ${PULSAR_CONFIG_webServiceEndpoint} \
    --broker-service-url ${PULSAR_CONFIG_brokerServiceEndpoint}

  touch /pulsar_data/.init_done
fi

# run broker node
export PULSAR_BROKER_CONF=${PULSAR_BROKER_CONF}
exec /pulsar/bin/pulsar broker
