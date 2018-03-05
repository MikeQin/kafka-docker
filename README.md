# Kafka 1.0.0 ( & Zookeeper) in Docker #
- Apache Kafka (1.0.0) Docker Image Bundled with Zookeeper

## Motivation ##
Why do I create this Kafka (& Zookeeper) docker image? Simply because I couldn't find any better Kafka docker images bundled with Zookeeper for my development needs. I need the latest Kafka 1.0.0 to work in docker. Explored spotify/kafka docker image (currently Kafka 0.10.1.0), and it's not up to date yet. Therefore, I've decided to create one myself.

## Environment ##
This is my environment for your reference. If your environment is different from mine, you can easily twist the settings for your own.

* Virtual Box (5.1.26) in Windows
* Ubuntu (16.04 LTS) in Virtual Box
* Installed Docker (17.12.0-ce, build c97c6d6) in Ubuntu

## Pull ##

```docker pull michaeldqin/kafka ```

This docker image is built on:
* Kafka version: 1.0.0
* Scala version: 2.12

## Run ##
### Kafka server container listening on 'localhost:9092' ###

* To allow host client or remote client to connect to Kafka server, your ADVERTISED_LISTENERS environment variable must set to 'localhost', and your Kafka server must run in a "localhost" mode:
```bash
docker run --rm -d -p 2181:2181 -p 9092:9092 \
    --env ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
    --name kafka -h kafka michaeldqin/kafka
```
* To start a producer (in host machine or remote), run:
```bash
$KAFKA_HOME/bin/kafka-console-producer.sh \
    --broker-list localhost:9092 --topic test
```
* To start a consumer (in host machine or remote), run:
```bash
$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
    --topic test --from-beginning
```

### Kafka server container listening on 'kafka:9092' ###

* To allow other containers to connect / link to Kafka server, you have to run the Kafka server in a "container" mode, the ADVERTISED_LISTENERS environment variable must set to 'kafka' instead:
```bash
docker run --rm -d -p 2181:2181 -p 9092:9092 \
    --env ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092 \
    --name kafka -h kafka michaeldqin/kafka
```
* To start a producer from another container that connects to Kafka server container, run:
```bash
docker run --rm -it --name producer --link kafka michaeldqin/kafka \
    kafka-console-producer.sh --broker-list kafka:9092 --topic test
```
* To start a consumer from third container that connects to Kafka server container, run:
```shell
docker run --rm -it --name consumer --link kafka michaeldqin/kafka \
    kafka-console-consumer.sh --bootstrap-server kafka:9092 \
    --topic test --from-beginning
```

## Kafka Broker Configurations ##

The following optional environment variables can be passed onto Kafka container during startup:

Use the following format:
```--env ENV_VARIABLE_NAME=[value]```

### BROKER CONFIGURATIONS ###

```
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
```

## Log ##

To access container start-up log, it's located in ```$KAFKA_HOME/log/start-kafka.log``` inside the container.

