#!/bin/bash

#current time
cur_time=`date +%Y-%m-%d_%H:%M:%S`
sed s/TIME/$cur_time/ /home/admin/gendata/source.temp > /home/admin/gendata/source.tp

#create data
for row in 1 2 3 4 5 6 7 8 9 10
do
  sed -n "${row}p" < /home/admin/gendata/source.tp > /home/admin/gendata/sline
  cnt=`shuf -i1-2 -n1`
  clr="red"
  if [ $cnt == 2 ]; then clr="yellow"; fi
  sed s/COLOR/$clr/ /home/admin/gendata/sline >> /home/admin/gendata/source.data
done
rm /home/admin/gendata/sline

rm /home/admin/gendata/source.tp

#import data
kafka-console-producer.sh --broker-list localhost:9092 --topic source < /home/admin/gendata/source.data

rm /home/admin/gendata/source.data

echo "insert data at ${cur_time}"

