#!/usr/bin/env bash
set -ex

# is it first time run and initialization is required?
if [[ ! -f /data/bookkeeper/.init_done ]]; then
  /opt/bookkeeper/scripts/entrypoint.sh /opt/bookkeeper/bin/bookkeeper shell metaformat -n -f
  touch /data/bookkeeper/.init_done
fi

# run bookie
/opt/bookkeeper/scripts/entrypoint.sh bookie
