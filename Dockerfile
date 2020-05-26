FROM golang:rc-alpine as builder
RUN	apk add --no-cache ca-certificates
WORKDIR /home
COPY . /home/
RUN set -x && env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o hello-webapp

FROM scratch
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs
COPY --from=builder /home/hello-webapp /usr/bin/hello-webapp
ENTRYPOINT [ "hello-webapp" ]
