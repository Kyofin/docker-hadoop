FROM  danisla/hadoop:2.7.2
USER  root
# spark3
COPY spark-3.1.1-bin-hadoop2.7.tgz   /opt
RUN tar zxvf /opt/spark-3.1.1-bin-hadoop2.7.tgz   -C /opt
COPY sleep.sh /opt
COPY juicefs-hadoop-1.0.0-rc2.jar /opt/spark-3.1.1-bin-hadoop2.7/jars
RUN rm -rf /opt/spark-3.1.1-bin-hadoop2.7.tgz


# kylin4
COPY apache-kylin-4.0.2-SNAPSHOT-bin-spark3.tar.gz /opt/
RUN tar zxvf /opt/apache-kylin-4.0.2-SNAPSHOT-bin-spark3.tar.gz -C /opt
RUN rm -rf /opt/apache-kylin-4.0.2-SNAPSHOT-bin-spark3.tar.gz

ENV HIVE_HOME=/opt/apache-hive-2.3.9-bin
ENV PATH=$PATH:$HIVE_HOME/bin

#  hive2
COPY apache-hive-2.3.9-bin.tar.gz /opt/apache-hive-2.3.9-bin.tar.gz
RUN  tar -zxvf /opt/apache-hive-2.3.9-bin.tar.gz -C /opt \
    && rm -f /opt/apache-hive-2.3.9-bin.tar.gz
COPY  mysql-connector-java-5.1.27.jar /opt/apache-hive-2.3.9-bin/lib/mysql-connector-java-5.1.27.jar

# init
RUN mkdir -p /opt/apache-kylin-4.0.2-SNAPSHOT-bin-spark3/hadoop_conf
RUN cp /opt/apache-hive-2.3.9-bin/lib/mysql-connector-java-5.1.27.jar /opt/apache-kylin-4.0.2-SNAPSHOT-bin-spark3/lib

RUN chmod +x /opt/sleep.sh
ENTRYPOINT ["/opt/sleep.sh"]
