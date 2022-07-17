docker build -f Dockerfile -t thrift:0.13 .

docker run -v "D:\workspace\docker-hadoop\thrift\:/data" --name thrift --rm -it  thrift:0.13  thrift  -o /data --gen go /data/fb303.thrift
docker run -v "D:\workspace\docker-hadoop\thrift\:/data" --name thrift --rm -it  thrift:0.13  thrift  -o /data --gen java /data/fb303.thrift
docker run -v "D:\workspace\docker-hadoop\thrift\:/data" --name thrift --rm -it  thrift:0.13  thrift  -o /data --gen py /data/fb303.thrift


