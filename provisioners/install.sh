#!/bin/bash

VERSION="0.15.0"
DIR="/opt/collector"


apt-get update
apt-get update
apt-get -y install default-jre
apt-get -y install unzip

mkdir $DIR
cd $DIR

mv /tmp/.env $DIR/.env
mv /tmp/config.hocon $DIR/config.hocon

wget https://dl.bintray.com/snowplow/snowplow-generic/snowplow_scala_stream_collector_google_pubsub_${VERSION}.zip
unzip snowplow_scala_stream_collector_google_pubsub_${VERSION}.zip

