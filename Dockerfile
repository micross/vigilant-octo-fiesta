FROM alpine:latest

# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk update --no-cache && apk add ca-certificates && apk add go

ADD . /opt/me
WORKDIR /opt/me

RUN CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o /nfs-subdir-external-provisioner .

RUN rm -rf /var/cache/apk/* /tmp/* /usr/share/man

ENTRYPOINT ["/nfs-subdir-external-provisioner"]
