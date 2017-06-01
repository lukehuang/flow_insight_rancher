#!/bin/bash

set -e

PLUGIN_TXT=${PLUGIN_TXT:-/usr/share/elasticsearch/plugins.txt}

while [ ! -f "/usr/share/elasticsearch/config/elasticsearch.yml" ]; do
    sleep 1
done

if [ -f "$PLUGIN_TXT" ]; then
    for plugin in $(<"${PLUGIN_TXT}"); do
        /usr/share/elasticsearch/bin/plugin --install $plugin
    done
fi

chown -R elasticsearch:elasticsearch /usr/share/elasticsearch
su elasticsearch
exec /usr/share/elasticsearch/bin/es-docker
