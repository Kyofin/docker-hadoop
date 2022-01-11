#!/bin/bash


echo "127.0.0.1 sandbox " >> /etc/hosts



# start doris
sh $DORIS_HOME/fe/bin/start_fe.sh --daemon
sh $DORIS_HOME/be/bin/start_be.sh --daemon

sleep 10s

# check fe ready
while true
do
  mysql -uroot -P 9030 -h sandbox -e "SHOW PROC '/frontends';"
  if [ $? -eq 0 ]
  then
    echo "fe mysql port is ready."
    break
  fi
  echo "try to connect doris mysql port fail...."
  sleep 5s
done


# register doris  be
beHost=`ifconfig -a |grep broadcast |awk -F ' '  '{print $2}'`

if [ ! -f "/home/admin/first_run" ]
then
    echo "register be node[${beHost}] to fe....."
    mysql -uroot -P 9030 -h sandbox -e "ALTER SYSTEM ADD BACKEND '${beHost}:9050' ; "
fi




touch /home/admin/first_run
sleep 10s


while :
do
    sleep 1
done
