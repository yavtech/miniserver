# Source: https://blog.logrocket.com/packaging-a-rust-web-service-using-docker/

FROM rust:alpine3.18 AS builder
RUN rustup target add x86_64-unknown-linux-musl
# This is important, see https://github.com/rust-lang/docker-rust/issues/85
ENV RUSTFLAGS="-C target-feature=-crt-static"

# if needed, add additional dependencies here
RUN apk add --no-cache musl-dev

WORKDIR /
RUN cargo new --bin miniserver
WORKDIR /miniserver
COPY ./Cargo.toml ./Cargo.toml
RUN cargo build --target x86_64-unknown-linux-musl --release
COPY . .
RUN rm target/x86_64-unknown-linux-musl/release/deps/miniserver*
RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:3.18
EXPOSE 8000

RUN apk update \
    && apk add --no-cache ca-certificates tzdata libgcc \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY --from=builder /miniserver/target/x86_64-unknown-linux-musl/release/miniserver /app/
ENTRYPOINT ["/app/miniserver"]