FROM  gitpod/workspace-full:2022-07-16-18-02-13

USER root
ENV PROTO_HOME /home/admin/proto
ENV PATH $PATH:$PROTO_HOME/bin

WORKDIR /home/admin

RUN mkdir -p $PROTO_HOME
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v21.2/protoc-21.2-linux-x86_64.zip -P $PROTO_HOME/
RUN cd $PROTO_HOME && unzip protoc-21.2-linux-x86_64.zip

ENV GOPROXY https://goproxy.cn
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28