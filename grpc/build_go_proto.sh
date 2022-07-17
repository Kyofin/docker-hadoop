docker build -f Dockerfile -t proto:3.21.2 .

docker run -v "D:\workspace\docker-hadoop\grpc\:/data" --name grpc --rm -it   proto:3.21.2   protoc   -I=/data --go_out=/data /data/hello.proto
docker run -v "D:\workspace\docker-hadoop\grpc\:/data" --name grpc --rm -it   proto:3.21.2   protoc   -I=/data --java_out=/data  /data/hello.proto

