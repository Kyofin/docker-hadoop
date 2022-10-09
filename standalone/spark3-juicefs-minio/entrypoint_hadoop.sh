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

# clean pid files
rm -f /tmp/*.pid
if [ ! -f "/home/admin/first_run" ]
then
    mysqld_pre_systemd
fi
mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid -u root
# start mysql
if [ ! -f "/home/admin/first_run" ]
then
    mysql_init_password=`cat /var/log/mysqld.log |grep -Po '(?<=A temporary password is generated for root@localhost: )\S+'`
    mysql --connect-expired-password -u root -p$mysql_init_password -e "set global validate_password_policy=0;set global validate_password_length=6;alter user user() identified by '123456';"
    mysql -uroot -p123456 -e "CREATE DATABASE IF NOT EXISTS kylin4 default charset utf8 COLLATE utf8_general_ci;"
    mysql -uroot -p123456 -e "CREATE DATABASE IF NOT EXISTS juicefs default charset utf8 COLLATE utf8_general_ci;"
    mysql -uroot -p123456 -e "grant all privileges on *.* to root@'%' identified by '123456';FLUSH   PRIVILEGES;"
fi



# start yarn
$HADOOP_HOME/sbin/yarn-daemon.sh start resourcemanager
$HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager


# start minio
nohup $MINIO_HOME/minio  server --address 0.0.0.0:9001  --console-address  0.0.0.0:9002  $MINIO_HOME/data > $MINIO_HOME/minio.log 2>&1 &

while true
do
  curl http://localhost:9001
  if [ $? -eq 0 ]
  then
    echo "minio is ready."
    break
  fi
  echo "try to connect minio api port fail...."
  sleep 5s
done

# setup juicefs
juicefs format --storage minio \
    --bucket http://localhost:9001/myjfs \
    --access-key minio \
    --secret-key minio123456 \
    "mysql://root:123456@(127.0.0.1:3306)/juicefs"  demofs

sleep 10s

function check_hdfs_usability() {
    echo "Checking HDFS's service..."
    started_hdfs=
    ((time_left = 60))
    while ((time_left > 0)); do
        hdfs dfs -test -d /tmp
        echo "Use hdfs cli to test...."
        started_hdfs=$?
        if [[ $started_hdfs -eq 0 ]]; then
            break
        fi
        sleep 5
        ((timeLeft -= 5))
    done
    if [[ $started_hdfs -eq 0 ]]; then
        echo "HDFS's service started..."
    else
        echo "ERROR: Check HDFS's service failed, please check the status of your cluster"
    fi
}

if [ ! -f "/home/admin/first_run" ]
then
    # check hdfs usability first if hdfs service was not started normally
    check_hdfs_usability

#    hdfs dfs -mkdir -p /kylin4/spark-history
    hdfs dfs -mkdir -p /spark_jars
    hdfs dfs -put -f $SPARK_HOME/jars/* /spark_jars/
#    hadoop jar /home/admin/hadoop-2.7.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar teragen 1000000 /teraInput
#    hadoop jar /home/admin/hadoop-2.7.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar terasort /teraInput /teraOutput
fi



touch /home/admin/first_run
sleep 10s


while :
do
    sleep 1
done
