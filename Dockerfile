FROM golang:1.13-alpine as builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o emulator .


FROM alpine:3.15.4

LABEL org.opencontainers.image.source=https://github.com/aertje/cloud-tasks-emulator

ENTRYPOINT ["/emulator"]

WORKDIR /

COPY --from=builder /app/emulator .
