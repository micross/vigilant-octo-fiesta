FROM golang:latest as build-env
COPY --from=tonistiigi/xx:golang-1.0.0 / /
ADD . /opt/build
WORKDIR /opt/build
RUN CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o /bin/main .

FROM alpine:latest
RUN apk update --no-cache && apk add ca-certificates
COPY --from=build-env /bin/main /main

ENTRYPOINT ["/main"]
