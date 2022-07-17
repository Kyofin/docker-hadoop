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

# Docker image with Hadoop/Spark/Hive/ZK/Kafka installed
FROM centos:7.9.2009

ENV THRIFT_VERSION 0.13.0


USER root

WORKDIR /home/admin

# install tools
RUN yum -y install lsof.x86_64 wget.x86_64 tar.x86_64 git.x86_64 which.x86_64 net-tools.x86_64  unzip.x86_64 numactl libaio   perl net-tools gcc

# install thrift
RUN wget https://archive.apache.org/dist/thrift/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz
RUN tar zxvf thrift-$THRIFT_VERSION.tar.gz
RUN yum install -y  gcc-c++
RUN yum install -y  make
RUN cd /home/admin/thrift-$THRIFT_VERSION && ./configure && make  && make install

