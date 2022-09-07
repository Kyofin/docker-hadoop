FROM poker/hadoop:2.7.2
ENV HIVE_HOME=/opt/apache-hive-2.3.9-bin

# setup hive
COPY apache-hive-2.3.9-bin.tar.gz /opt/apache-hive-2.3.9-bin.tar.gz
RUN  tar -zxvf /opt/apache-hive-2.3.9-bin.tar.gz -C /opt \
    && rm -f /opt/apache-hive-2.3.9-bin.tar.gz

COPY  mysql-connector-java-5.1.27.jar /opt/apache-hive-2.3.9-bin/lib/mysql-connector-java-5.1.27.jar
COPY juicefs-hadoop-1.0.0-rc2.jar /opt/apache-hive-2.3.9-bin/lib/juicefs-hadoop-1.0.0-rc2.jar

COPY bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh

ENTRYPOINT ["/opt/bootstrap.sh"]
