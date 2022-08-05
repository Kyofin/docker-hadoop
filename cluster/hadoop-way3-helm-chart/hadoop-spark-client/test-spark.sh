/opt/spark-3.1.2-bin-hadoop2.7/bin/spark-submit --master yarn --deploy-mode client --class org.apache.spark.examples.SparkPi examples/jars/spark-examples_2.12-3.1.2.jar
/opt/spark-3.1.2-bin-hadoop2.7/bin/spark-submit  --master yarn --deploy-mode cluster  --class org.apache.spark.examples.SparkPi examples/jars/spark-examples_2.12-3.1.2.jar
# 使用juicefs-hadoop jar做测试
/usr/local/hadoop/bin/hadoop jar /opt/spark-3.1.2-bin-hadoop2.7/jars/juicefs-hadoop-1.0.0-rc2.jar  dfsio -write -maps 10 -size 10000 -baseDir hdfs:///tmp/benchmarks/DFSIO
/usr/local/hadoop/bin/hadoop jar /opt/spark-3.1.2-bin-hadoop2.7/jars/juicefs-hadoop-1.0.0-rc2.jar  dfsio -read -maps 10 -size 10000 -baseDir hdfs:///tmp/benchmarks/DFSIO

/usr/local/hadoop/bin/hadoop jar /opt/spark-3.1.2-bin-hadoop2.7/jars/juicefs-hadoop-1.0.0-rc2.jar  nnbench create -maps 10 -threads 10 -files 1000 -baseDir hdfs:///tmp/benchmarks/NNBench
/usr/local/hadoop/bin/hadoop jar /opt/spark-3.1.2-bin-hadoop2.7/jars/juicefs-hadoop-1.0.0-rc2.jar  nnbench open -maps 10 -threads 10 -files 1000 -baseDir hdfs:///tmp/benchmarks/NNBench
/usr/local/hadoop/bin/hadoop jar /opt/spark-3.1.2-bin-hadoop2.7/jars/juicefs-hadoop-1.0.0-rc2.jar  nnbench rename -maps 10 -threads 10 -files 1000 -baseDir hdfs:///tmp/benchmarks/NNBench
/usr/local/hadoop/bin/hadoop jar /opt/spark-3.1.2-bin-hadoop2.7/jars/juicefs-hadoop-1.0.0-rc2.jar  nnbench delete -maps 10 -threads 10 -files 1000 -baseDir hdfs:///tmp/benchmarks/NNBench
