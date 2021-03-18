FROM golang:latest as build-env
ADD . /opt/build
WORKDIR /opt/build
RUN CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o /bin/nfs-subdir-external-provisioner .

FROM alpine:latest
RUN apk update --no-cache && apk add ca-certificates
COPY --from=build-env /bin/nfs-subdir-external-provisioner /nfs-subdir-external-provisioner

ENTRYPOINT ["/nfs-subdir-external-provisioner"]
