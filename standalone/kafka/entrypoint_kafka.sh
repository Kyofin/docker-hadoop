#!/bin/bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
echo "127.0.0.1 sandbox sandbox.hortonworks.com" >> /etc/hosts



 start zk
 rm -rf /data/zookeeper/*
 rm -f /data/zookeeper/zookeeper_server.pid
 $ZK_HOME/bin/zkServer.sh start

 start kafka
 rm -rf /tmp/kafka-logs
 nohup $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &

sleep 10s




# prepare kafka topic and data
 if [ ! -f "/home/admin/first_run" ]
 then
     $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic source
     $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic target
 fi




touch /home/admin/first_run
sleep 10s

# mock data
sh /home/admin/gendata/streaming-data.sh

while :
do
    sleep 1
done
