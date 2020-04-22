#!/usr/bin/env bash
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

exec /pulsar/bin/pulsar broker
