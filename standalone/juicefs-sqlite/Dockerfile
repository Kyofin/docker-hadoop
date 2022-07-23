FROM alpine:latest
LABEL maintainer="Juicedata <https://juicefs.com>"

ENV MINIO_ROOT_USER minio
ENV MINIO_ROOT_PASSWORD minio123

# Install JuiceFS client
RUN apk add --no-cache curl
COPY ./juicefs-1.0.0-rc3-linux-amd64.tar.gz juicefs-1.0.0-rc3-linux-amd64.tar.gz
RUN tar -zxf "juicefs-1.0.0-rc3-linux-amd64.tar.gz" && \
  install juicefs /usr/bin && \
  rm juicefs "juicefs-1.0.0-rc3-linux-amd64.tar.gz" && \
  rm -rf /var/cache/apk/*


RUN juicefs format sqlite3://myjfs.db myjfs
ENTRYPOINT ["juicefs","gateway","sqlite3://myjfs.db",":9100"]

