FROM golang:1.19.1-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "SignTools"

FROM alpine:3.17.1

WORKDIR /

COPY --from=builder "/src/SignTools" "/"

ENTRYPOINT ["/SignTools"]
EXPOSE 8080