#!/bin/bash
### BROKER CONFIGURATIONS ####
# Optional ENV variables:

# DEFAULT: advertised.listeners=null
#ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092

# DEFAULT: auto.create.topics.enable=true
#AUTO_CREATE_TOPICS_ENABLE=true

# DEFAULT: auto.leader.rebalance.enable=true
#AUTO_LEADER_REBALANCE_ENABLE=true

# DEFAULT: delete.topic.enable=true
#DELETE_TOPIC_ENABLE=true

# DEFAULT: broker.id=0
#BROKER_ID=100

# DEFAULT: log.dirs=/tmp/kafka-logs
#LOG_DIRS=/tmp/kafka-logs

# DEFAULT: num.partitions=1
#NUM_PARTITONS=1

# DEFAULT: log.retention.hours=168
#LOG_RETENTION_HOURS=168

# DEFAULT: log.retention.bytes=-1
#LOG_RETENTION_BYTES=1073741824

# DEFAULT: socket.send.buffer.bytes=102400
#SOCKET_SEND_BUFFER_BYTES=204800

# DEFAULT: socket.receive.buffer.bytes=102400
#SOCKET_RECEIVE_BUFFER_BYTES=204800

# DEFAULT: zookeeper.connect=localhost:2181
#ZOOKEEPER_CONNECT=localhost:2181

# DEFAULT: zookeeper.connection.timeout.ms=6000
#ZOOKEEPER_CONNECTION_TIMEOUT_MS=12000

# Deprecated ADVERTISED_HOST
#ADVERTISED_HOST=localhost

# Deprecated ADVERTISED_PORT
#ADVERTISED_PORT=9092

# Prepare log
if [ ! -d $KAFKA_HOME/log ]; then
    mkdir $KAFKA_HOME/log
fi
declare -r LOGS=$KAFKA_HOME/log/start-kafka.log

# Start logging
echo "[*] KAFKA_HOME=$KAFKA_HOME" > ${LOGS}
echo "[*] BEGIN configure: $KAFKA_HOME/config/server.properties" >> ${LOGS}

#----------------------------------------
# Handle deprecated configurations
if [ ! -z "$ADVERTISED_HOST" ]; then
    echo "[ERROR] ADVERTISED_HOST=$ADVERTISED_HOST was deprecated. Setting it has no effect. Use ADVERTISED_LISTENERS instead." >> ${LOGS}
fi
if [ ! -z "$ADVERTISED_PORT" ]; then
    echo "[ERROR] ADVERTISED_PORT=$ADVERTISED_PORT was deprecated. Setting it has no effect. Use ADVERTISED_LISTENERS instead." >> ${LOGS}
fi
#----------------------------------------

# SET: advertised.listeners=
if [ ! -z "$ADVERTISED_LISTENERS" ]; then
    if grep -q "#advertised.listeners" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|#(advertised.listeners)=(.*)|\1=$ADVERTISED_LISTENERS|g" $KAFKA_HOME/config/server.properties      
    elif grep -q "^advertised.listeners" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(advertised.listeners)=(.*)|\1=$ADVERTISED_LISTENERS|g" $KAFKA_HOME/config/server.properties
    fi
    echo "[*] advertised.listeners=$ADVERTISED_LISTENERS" >> ${LOGS}
fi

# SET: auto.create.topics.enable=true
if [ ! -z "$AUTO_CREATE_TOPICS_ENABLE" ]; then
    if grep -q "^auto.create.topics.enable" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(auto.create.topics.enable)=(.*)|\1=$AUTO_CREATE_TOPICS_ENABLE|g" $KAFKA_HOME/config/server.properties
    else
        echo -e "\r" >> $KAFKA_HOME/config/server.properties
        echo "auto.create.topics.enable=$AUTO_CREATE_TOPICS_ENABLE" >> $KAFKA_HOME/config/server.properties
    fi
    echo "[*] auto.create.topics.enable=$AUTO_CREATE_TOPICS_ENABLE" >> ${LOGS}
fi

# SET: auto.leader.rebalance.enable=true
if [ ! -z "$AUTO_LEADER_REBALANCE_ENABLE" ]; then
    if grep -q "^auto.leader.rebalance.enable" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(auto.leader.rebalance.enable)=(.*)|\1=$AUTO_LEADER_REBALANCE_ENABLE|g" $KAFKA_HOME/config/server.properties
    else
        echo -e "\r" >> $KAFKA_HOME/config/server.properties
        echo "auto.leader.rebalance.enable=$AUTO_LEADER_REBALANCE_ENABLE" >> $KAFKA_HOME/config/server.properties
    fi
    echo "[*] auto.leader.rebalance.enable=$AUTO_LEADER_REBALANCE_ENABLE" >> ${LOGS}
fi

# SET: delete.topic.enable=true
if [ ! -z "$DELETE_TOPIC_ENABLE" ]; then
    if grep -q "^delete.topic.enable" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(delete.topic.enable)=(.*)|\1=$DELETE_TOPIC_ENABLE|g" $KAFKA_HOME/config/server.properties
    else
        echo -e "\r" >> $KAFKA_HOME/config/server.properties
        echo "delete.topic.enable=$DELETE_TOPIC_ENABLE" >> $KAFKA_HOME/config/server.properties
    fi
    echo "[*] delete.topic.enable=$DELETE_TOPIC_ENABLE" >> ${LOGS}
fi

# SET: broker.id=0
if [ ! -z "$BROKER_ID" ]; then
    if grep -q "^broker.id" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(broker.id)=(.*)|\1=$BROKER_ID|g" $KAFKA_HOME/config/server.properties
        echo "[*] broker.id=$BROKER_ID" >> ${LOGS}
    fi
fi

# SET: log.dirs=/tmp/kafka-logs
if [ ! -z "$LOG_DIRS" ]; then
    if grep -q "^log.dirs" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(log.dirs)=(.*)|\1=$LOG_DIRS|g" $KAFKA_HOME/config/server.properties
        echo "[*] log.dirs=$LOG_DIRS" >> ${LOGS}
    fi
fi

# SET: num.partitions=1
if [ ! -z "$NUM_PARTITIONS" ]; then
    if grep -q "^num.partitions" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(num.partitions)=(.*)|\1=$NUM_PARTITIONS|g" $KAFKA_HOME/config/server.properties
        echo "[*] num.partitions=$NUM_PARTITIONS" >> ${LOGS}
    fi
fi

# SET: log.retention.hours=168
if [ ! -z "$LOG_RETENTION_HOURS" ]; then
    if grep -q "^log.retention.hours" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(log.retention.hours)=(.*)|\1=$LOG_RETENTION_HOURS|g" $KAFKA_HOME/config/server.properties
        echo "[*] log.retention.hours=$LOG_RETENTION_HOURS" >> ${LOGS}
    fi
fi

# SET: log.retention.bytes=1073741824
if [ ! -z "$LOG_RETENTION_BYTES" ]; then
    if grep -q "#log.retention.bytes" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|#(log.retention.bytes)=(.*)|\1=$LOG_RETENTION_BYTES|g" $KAFKA_HOME/config/server.properties
    elif grep -q "^log.retention.bytes" $KAFKA_HOME/config/server.properties; then
	sed -r -i "s|(log.retention.bytes)=(.*)|\1=$LOG_RETENTION_BYTES|g" $KAFKA_HOME/config/server.properties
    fi
    echo "[*] log.retention.bytes=$LOG_RETENTION_BYTES" >> ${LOGS}
fi

# SET: socket.send.buffer.bytes=204800
if [ ! -z "$SOCKET_SEND_BUFFER_BYTES" ]; then
    if grep -q "^socket.send.buffer.bytes" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(socket.send.buffer.bytes)=(.*)|\1=$SOCKET_SEND_BUFFER_BYTES|g" $KAFKA_HOME/config/server.properties
        echo "[*] socket.send.buffer.bytes=$SOCKET_SEND_BUFFER_BYTES" >> ${LOGS}
    fi
fi

# SET: socket.receive.buffer.bytes=204800
if [ ! -z "$SOCKET_RECEIVE_BUFFER_BYTES" ]; then
    if grep -q "^socket.receive.buffer.bytes" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(socket.receive.buffer.bytes)=(.*)|\1=$SOCKET_RECEIVE_BUFFER_BYTES|g" $KAFKA_HOME/config/server.properties
        echo "[*] socket.receive.buffer.bytes=$SOCKET_RECEIVE_BUFFER_BYTES" >> ${LOGS}
    fi
fi

# SET: zookeeper.connect=localhost:2181
if [ ! -z "$ZOOKEEPER_CONNECT" ]; then
    if grep -q "^zookeeper.connect" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(zookeeper.connect)=(.*)|\1=$ZOOKEEPER_CONNECT|g" $KAFKA_HOME/config/server.properties
        echo "[*] zookeeper.connect=$ZOOKEEPER_CONNECT" >> ${LOGS}
    fi
fi

# SET: zookeeper.connection.timeout.ms=12000
if [ ! -z "$ZOOKEEPER_CONNECTION_TIMEOUT_MS" ]; then
    if grep -q "^zookeeper.connection.timeout.ms" $KAFKA_HOME/config/server.properties; then
        sed -r -i "s|(zookeeper.connection.timeout.ms)=(.*)|\1=$ZOOKEEPER_CONNECTION_TIMEOUT_MS|g" $KAFKA_HOME/config/server.properties
        echo "[*] zookeeper.connection.timeout.ms=$ZOOKEEPER_CONNECTION_TIMEOUT_MS" >> ${LOGS}
    fi
fi

# End of broker configurations update
echo "[*] END configure: $KAFKA_HOME/config/server.properties" >> ${LOGS}

# Run Kafka
declare -r DT=$(date '+%d/%m/%Y %H:%M:%S')
echo "[*] Starting Kafka at ${DT}" >> ${LOGS}
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
