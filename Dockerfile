FROM alpine:3.18 as builder

RUN apk add --no-cache \
    alpine-sdk \
    bash \
    cmake \
    g++ \
    gcc \
    icu-dev \
    icu-libs

WORKDIR /workspace

COPY . .

RUN ./RUNME.sh build


FROM alpine:3.18

RUN apk add --no-cache \
    icu \
    icu-data-full

COPY --from=builder /workspace/build/release/peaclock /usr/bin/peaclock
COPY --from=builder /workspace/cfg/* /root/.peaclock/config/

ENTRYPOINT [ "peaclock" ]
