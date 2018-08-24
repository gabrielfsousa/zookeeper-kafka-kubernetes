#!/bin/sh

export KAFKA_BROKER_ID=$((${HOSTNAME##*-} + 1))

KAFKA_CONFIG_DIR=/opt/kafka/config

if [ -n "$KAFKA_LOCAL_CONFIG" ]; then
	echo "$KAFKA_LOCAL_CONFIG" > "$KAFKA_CONFIG_DIR/server.properties"
fi

sed -i 's/#broker.id=/broker.id='$KAFKA_BROKER_ID'/g' /opt/kafka/config/server.properties
sed -i 's/:9194/'${MY_NODE_NAME}'.domain.com:9194/g' /opt/kafka/config/server.properties

exec "$@"
