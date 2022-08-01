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

SCRIPT_PATH=$(cd `dirname $0`; pwd)
WS_ROOT=`dirname $SCRIPT_PATH`
HADOOP_VERSION="2.8.5"

docker build -t apachekylin/kylin-ci-hadoop-base:hadoop_${HADOOP_VERSION}  ./dockerfile/cluster/base
docker build -t apachekylin/kylin-ci-hadoop-namenode:hadoop_${HADOOP_VERSION} ./dockerfile/cluster/namenode
docker build -t apachekylin/kylin-ci-hadoop-datanode:hadoop_${HADOOP_VERSION}  ./dockerfile/cluster/datanode
docker build -t apachekylin/kylin-ci-hadoop-resourcemanager:hadoop_${HADOOP_VERSION} ./dockerfile/cluster/resourcemanager
docker build -t apachekylin/kylin-ci-hadoop-nodemanager:hadoop_${HADOOP_VERSION} ./dockerfile/cluster/nodemanager
docker build -t apachekylin/kylin-ci-hadoop-historyserver:hadoop_${HADOOP_VERSION} ./dockerfile/cluster/historyserver

