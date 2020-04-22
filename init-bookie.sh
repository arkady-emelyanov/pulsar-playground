#!/usr/bin/env bash
# Apache BookKeeper cluster initialization
# script should be run only once at any cluster node
set -ex

# is it first time run and initialization is required?
if [[ ! -f /data/bookkeeper/.init_done ]]; then
  /opt/bookkeeper/scripts/entrypoint.sh /opt/bookkeeper/bin/bookkeeper shell metaformat -n -f
  touch /data/bookkeeper/.init_done
fi

# run bookie node
/opt/bookkeeper/scripts/entrypoint.sh bookie
