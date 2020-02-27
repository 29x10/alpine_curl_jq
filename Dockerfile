FROM alpine:3.11


ENV LANG C.UTF-8


RUN apk add --no-cache ca-certificates curl jq


CMD ["/bin/sh"]
