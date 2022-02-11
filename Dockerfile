FROM golang:1.17.7-alpine AS builder

WORKDIR /src
COPY . .

RUN go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "webdav-server"

FROM alpine:3.14.3

WORKDIR /

COPY --from=builder "/src/webdav-server" "/"

ENTRYPOINT ["/webdav-server"]
EXPOSE 8081
