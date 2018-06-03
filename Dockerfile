# build stage
FROM golang:1.9-alpine AS build-env

ARG COMMIT
ARG REPO

WORKDIR /go/src/github.com/ju663rnaut/app
ADD ./cmd ./cmd
ADD ./vendor ./vendor

RUN go build -o /tmp/app ./cmd/app/main.go
RUN chmod +x /tmp/app

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /tmp/app /app/
ENTRYPOINT ["./app"]
